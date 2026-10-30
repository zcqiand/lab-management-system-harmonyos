// 首页（lab 首业务消费切片）：AuthApi.login（后端代理 saas IdP，无 clientId 面）→
// SessionState → CatalogApi.listBrands 只读列表。base URL 走 rawfile config.json
// （AppConfig fail-fast，禁默认值兜底）；错误显示 ApiError 的 code+message。
import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { ApiError } from 'harmonyos-api-runtime';
import { CatalogListBrandsResponse } from '../shared/models/CatalogListBrandsResponse';
import { InspectionBrand } from '../shared/models/InspectionBrand';
import { InspectionReportName } from '../shared/models/InspectionReportName';
import { CalculationMethod } from '../shared/models/CalculationMethod';
import { TechnicalRequirement } from '../shared/models/TechnicalRequirement';
import { InspectionSpecialty } from '../shared/models/InspectionSpecialty';
import { InspectionObject } from '../shared/models/InspectionObject';
import { InspectionParameter } from '../shared/models/InspectionParameter';
import { InspectionStandard } from '../shared/models/InspectionStandard';
import { ParamInterface } from '../shared/models/ParamInterface';
import { Contract } from '../shared/models/Contract';
import { SampleReceipt } from '../shared/models/SampleReceipt';
import { Sample } from '../shared/models/Sample';
import { TestRecord } from '../shared/models/TestRecord';
import { DashboardStats } from '../shared/models/DashboardStats';
import { SummaryData } from '../shared/models/SummaryData';
import { SummaryColumn } from '../shared/models/SummaryColumn';
import { ContractForm } from '../forms/ContractForms';
import { session } from '../session/Session';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State message: string = '实验室管理系统（HarmonyOS ArkTS 版）';
  @State busy: boolean = false;
  @State loggedIn: boolean = false;
  @State brands: CatalogListBrandsResponse | null = null;
  @State reportNames: InspectionReportName[] = [];
  @State calcMethods: CalculationMethod[] = [];
  @State techReqs: TechnicalRequirement[] = [];
  @State specialties: InspectionSpecialty[] = [];
  @State objects: InspectionObject[] = [];
  @State parameters: InspectionParameter[] = [];
  @State standards: InspectionStandard[] = [];
  @State paramInterfaces: ParamInterface[] = [];
  @State contracts: Contract[] = [];
  @State receipts: SampleReceipt[] = [];
  @State samples: Sample[] = [];
  @State testRecords: TestRecord[] = [];
  @State stats: DashboardStats | null = null;
  @State reportSummary: SummaryData | null = null;
  @State statLines: string[] = [];
  @State summaryLines: string[] = [];
  // 写面（合同 CRUD）：表单态 + 编辑中合同 id（'' = 创建态）
  @State formCode: string = '';
  @State formClientUnit: string = '';
  @State formProjectName: string = '';
  @State formConstructionUnit: string = '';
  @State formWitnessUnit: string = '';
  @State formWitness: string = '';
  @State formProjectLocation: string = '';
  @State formStatus: string = '';
  @State editingContractId: string = '';

  private async ensureConfigured(): Promise<void> {
    if (this.loggedIn) {
      return;
    }
    const ctx = getContext(this) as common.UIAbilityContext;
    const raw = await ctx.resourceManager.getRawFileContent('config.json');
    const text = util.TextDecoder.create('utf-8').decodeToString(raw);
    session.configure(text);
    if (session.authenticated()) {
      this.loggedIn = true;
    }
  }

  private async loadBrands(): Promise<void> {
    this.brands = await session.listBrands(1, 20);
  }

  // 码表只读区（片2）：报告名称/计算方法/技术要求三张表（lab 不切片，全量回显）
  private async loadCodeTables(): Promise<void> {
    const rn = await session.listReportNames(1, 20);
    this.reportNames = rn.items;
    this.calcMethods = await session.listCalculationMethods();
    this.techReqs = await session.listTechnicalRequirements();
  }

  // 检测能力只读区（片3）：专业/对象/参数/标准 + 参数界面
  private async loadCapability(): Promise<void> {
    this.specialties = (await session.listSpecialties(1, 20)).items;
    this.objects = (await session.listObjects(1, 20)).items;
    this.parameters = (await session.listParameters(1, 20)).items;
    this.standards = (await session.listStandards(1, 20)).items;
    this.paramInterfaces = (await session.listParamInterfaces(1, 20)).items;
  }

  // 业务数据只读区（片4）：合同/委托/样品/记录
  private async loadBusiness(): Promise<void> {
    this.contracts = (await session.listContracts(1, 20)).items;
    this.receipts = (await session.listReceipts(1, 20)).items;
    this.samples = (await session.listSamples(1, 20)).items;
    this.testRecords = (await session.listTestRecords(1, 20)).items;
  }

  // 汇总只读区（片5）：仪表盘计数 + 报表汇总（FrontendBindMeta @deprecated 不接）
  // Map 字段（Map<string,string>）在装载时展平为行字符串——ArkTS ForEach 只吃 Array
  private mapLines(m: Map<string, string>): string[] {
    const lines: string[] = [];
    m.forEach((v: string, k: string) => {
      lines.push(`${k}=${v}`);
    });
    return lines;
  }

  private async loadSummary(): Promise<void> {
    this.stats = await session.getDashboardStats();
    this.reportSummary = await session.getReportSummary();
    const s = this.stats;
    if (s !== null) {
      this.statLines = [
        `合同 ${s.contractCount} · 委托 ${s.receiptCount} · 样品 ${s.sampleCount}`,
        `待办任务 ${s.pendingTaskCount} · 今日检测 ${s.todayTestCount}`,
      ].concat(this.mapLines(s.reportCountByStatus))
        .concat(this.mapLines(s.qualifiedRateByMaterial))
        .concat(this.mapLines(s.reportOutputByStatus))
        .concat(this.mapLines(s.funnelByStage));
    }
    const rs = this.reportSummary;
    if (rs !== null) {
      const head = rs.columns.map((c: SummaryColumn) => c.label).join(' | ');
      this.summaryLines = [`${rs.summaryName}（列：${head}）`];
      rs.rows.forEach((row: Map<string, string>) => {
        const cells = rs.columns.map((c: SummaryColumn) => {
          const v = row.get(c.key);
          return v !== undefined ? v : '—';
        });
        this.summaryLines.push(cells.join(' | '));
      });
    }
  }

  private async doLogin(): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    this.message = '';
    try {
      await this.ensureConfigured();
      await session.login(this.username, this.password);
      await this.loadBrands();
      await this.loadCodeTables();
      await this.loadCapability();
      await this.loadBusiness();
      await this.loadSummary();
      this.loggedIn = true;
    } catch (err) {
      const apiErr = err as ApiError;
      if (apiErr.code !== undefined && apiErr.code !== '') {
        this.message = `登录失败：${apiErr.code} ${apiErr.message}`;
      } else {
        this.message = `登录失败：${(err as Error).message}`;
      }
    } finally {
      this.busy = false;
    }
  }

  // 写面（合同 CRUD）：表单态 → ContractForm → Session（fail-fast 在装配层，错误显 message）
  private currentForm(): ContractForm {
    let f: ContractForm = {
      contractCode: this.formCode,
      clientUnit: this.formClientUnit,
      projectName: this.formProjectName,
      constructionUnit: this.formConstructionUnit,
      witnessUnit: this.formWitnessUnit,
      witness: this.formWitness,
      projectLocation: this.formProjectLocation,
      status: this.formStatus
    };
    return f;
  }

  private resetForm(): void {
    this.formCode = '';
    this.formClientUnit = '';
    this.formProjectName = '';
    this.formConstructionUnit = '';
    this.formWitnessUnit = '';
    this.formWitness = '';
    this.formProjectLocation = '';
    this.formStatus = '';
    this.editingContractId = '';
  }

  private async submitCreate(): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    this.message = '';
    try {
      const created = await session.createContract(this.currentForm());
      this.message = `已创建合同 ${created.contractCode}`;
      this.resetForm();
      await this.loadBusiness();
      await this.loadSummary();
    } catch (err) {
      this.message = `创建失败：${(err as Error).message}`;
    } finally {
      this.busy = false;
    }
  }

  private async submitUpdate(): Promise<void> {
    if (this.busy || this.editingContractId === '') {
      return;
    }
    this.busy = true;
    this.message = '';
    try {
      const updated = await session.updateContract(this.editingContractId, this.currentForm());
      this.message = `已更新合同 ${updated.contractCode}`;
      this.resetForm();
      await this.loadBusiness();
    } catch (err) {
      this.message = `更新失败：${(err as Error).message}`;
    } finally {
      this.busy = false;
    }
  }

  private async submitDelete(id: string): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    this.message = '';
    try {
      await session.deleteContract(id);
      this.message = `已删除合同（id=${id}）`;
      if (this.editingContractId === id) {
        this.resetForm();
      }
      await this.loadBusiness();
      await this.loadSummary();
    } catch (err) {
      this.message = `删除失败：${(err as Error).message}`;
    } finally {
      this.busy = false;
    }
  }

  private startEdit(id: string): void {
    for (let i = 0; i < this.contracts.length; i++) {
      if (this.contracts[i].id === id) {
        const c = this.contracts[i];
        this.formCode = c.contractCode;
        this.formClientUnit = c.clientUnit;
        this.formProjectName = c.projectName;
        this.formConstructionUnit = c.constructionUnit;
        this.formWitnessUnit = c.witnessUnit;
        this.formWitness = c.witness;
        this.formProjectLocation = c.projectLocation !== undefined ? c.projectLocation : '';
        this.formStatus = '';
        this.editingContractId = id;
        this.message = `编辑中：${c.contractCode}（留空字段不动，状态留空不改）`;
        return;
      }
    }
  }

  private async doLogout(): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    try {
      await session.logout();
    } catch (err) {
      this.message = `登出异常：${(err as Error).message}`;
    } finally {
      this.loggedIn = false;
      this.brands = null;
      this.reportNames = [];
      this.calcMethods = [];
      this.techReqs = [];
      this.specialties = [];
      this.objects = [];
      this.parameters = [];
      this.standards = [];
      this.paramInterfaces = [];
      this.contracts = [];
      this.receipts = [];
      this.samples = [];
      this.testRecords = [];
      this.stats = null;
      this.reportSummary = null;
      this.statLines = [];
      this.summaryLines = [];
      this.resetForm();
      this.password = '';
      this.busy = false;
    }
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
      Text('实验室管理系统')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
      Text('HarmonyOS ArkTS（X14 槽）')
        .fontSize(13)
        .opacity(0.6)

      if (!this.loggedIn) {
        TextInput({ placeholder: '用户名', text: this.username })
          .width('80%')
          .onChange((v: string) => {
            this.username = v;
          })
        TextInput({ placeholder: '密码', text: this.password })
          .type(InputType.Password)
          .width('80%')
          .onChange((v: string) => {
            this.password = v;
          })
        Button(this.busy ? '登录中…' : '登录')
          .width('80%')
          .enabled(!this.busy)
          .onClick(() => {
            this.doLogin();
          })
      } else {
        Text(`检验品牌（共 ${this.brands !== null ? this.brands.total : 0} 条）`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        if (this.brands !== null && this.brands.items.length > 0) {
          List() {
            ForEach(this.brands.items, (item: InspectionBrand) => {
              ListItem() {
                Column({ space: 2 }) {
                  Text(`${item.code} · ${item.name}`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text(item.remark !== undefined ? item.remark : '—')
                    .fontSize(12)
                    .opacity(0.6)
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')
              }
              .padding(6)
            }, (item: InspectionBrand) => item.code)
          }
          .width('88%')
          .height('22%')
        } else {
          Text('（无品牌数据）')
            .fontSize(13)
            .opacity(0.6)
        }
        Text(`码表 · 报告名称（${this.reportNames.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.reportNames, (item: InspectionReportName) => {
            ListItem() {
              Text(`${item.code} · ${item.name}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: InspectionReportName) => item.code)
        }
        .width('88%')
        .height(this.reportNames.length > 3 ? '10%' : undefined)
        Text(`码表 · 计算方法（${this.calcMethods.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.calcMethods, (item: CalculationMethod) => {
            ListItem() {
              Text(`${item.inspectionObjectCode}/${item.inspectionParameterCode} · ${item.algorithmType} · 试件 ${item.specimenCount}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: CalculationMethod) => `${item.inspectionObjectCode}/${item.inspectionParameterCode}`)
        }
        .width('88%')
        .height(this.calcMethods.length > 3 ? '10%' : undefined)
        Text(`码表 · 技术要求（${this.techReqs.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.techReqs, (item: TechnicalRequirement) => {
            ListItem() {
              Text(`${item.inspectionObjectCode}/${item.inspectionParameterCode}/${item.judgmentStandardCode} · ${item.valueType}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: TechnicalRequirement) => `${item.inspectionObjectCode}/${item.inspectionParameterCode}/${item.judgmentStandardCode}`)
        }
        .width('88%')
        .height(this.techReqs.length > 3 ? '10%' : undefined)
        Text(`检测能力 · 专业（${this.specialties.length}）/ 对象（${this.objects.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.specialties, (item: InspectionSpecialty) => {
            ListItem() {
              Text(`专业 ${item.officialNo} · ${item.name}（${item.code}${item.enabled ? '' : ' · 停用'}）`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: InspectionSpecialty) => item.code)
          ForEach(this.objects, (item: InspectionObject) => {
            ListItem() {
              Text(`对象 ${item.name}（${item.code} · ${item.inspectionSpecialtyCode}）`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: InspectionObject) => item.code)
        }
        .width('88%')
        .height('12%')
        Text(`检测能力 · 参数（${this.parameters.length}）/ 标准（${this.standards.length}）/ 界面（${this.paramInterfaces.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.parameters, (item: InspectionParameter) => {
            ListItem() {
              Text(`参数 ${item.name}（${item.code}${item.unit !== undefined ? ` · ${item.unit}` : ''}）`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: InspectionParameter) => item.code)
          ForEach(this.standards, (item: InspectionStandard) => {
            ListItem() {
              Text(`标准 ${item.name}（${item.code}${item.version !== undefined ? ` ${item.version}` : ''} · ${item.status}）`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: InspectionStandard) => item.code)
          ForEach(this.paramInterfaces, (item: ParamInterface) => {
            ListItem() {
              Text(`界面 ${item.componentPath}（${item.code}）`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: ParamInterface) => item.code)
        }
        .width('88%')
        .height('14%')
        Text(`业务数据 · 合同（${this.contracts.length}）/ 委托（${this.receipts.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.contracts, (item: Contract) => {
            ListItem() {
              Row({ space: 8 }) {
                Text(`合同 ${item.contractCode} · ${item.projectName}（${item.clientUnit}）`)
                  .fontSize(13)
                  .layoutWeight(1)
                Button('改')
                  .fontSize(11)
                  .onClick(() => {
                    this.startEdit(item.id);
                  })
                // @entry M02.F01.I05 删除合同
                Button('删')
                  .fontSize(11)
                  .onClick(() => {
                    this.submitDelete(item.id);
                  })
              }
              .width('100%')
            }
            .padding(3)
          }, (item: Contract) => item.id)
          ForEach(this.receipts, (item: SampleReceipt) => {
            ListItem() {
              Text(`委托 ${item.commissionCode} · ${item.categoryCode}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: SampleReceipt) => item.id)
        }
        .width('88%')
        .height('12%')
        Text(`业务数据 · 样品（${this.samples.length}）/ 记录（${this.testRecords.length}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.samples, (item: Sample) => {
            ListItem() {
              Text(`样品 ${item.sampleCode}${item.sampleName !== undefined ? ` · ${item.sampleName}` : ''}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: Sample) => item.id)
          ForEach(this.testRecords, (item: TestRecord) => {
            ListItem() {
              Text(`记录 ${item.parameterCode} · 要求 ${item.requirement} → 结果 ${item.result}`)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (item: TestRecord) => item.id)
        }
        .width('88%')
        .height('12%')
        Text('汇总 · 仪表盘')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.statLines, (line: string) => {
            ListItem() {
              Text(line)
                .fontSize(13)
                .width('100%')
            }
            .padding(3)
          }, (line: string) => line)
        }
        .width('88%')
        .height('12%')
        Text(`汇总 · 报表（${this.reportSummary !== null ? this.reportSummary.summaryName : '—'}）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        List() {
          ForEach(this.summaryLines, (line: string) => {
            ListItem() {
              Text(line)
                .fontSize(12)
                .width('100%')
            }
            .padding(3)
          }, (line: string, idx: number) => `${idx}-${line}`)
        }
        .width('88%')
        .height('12%')
        Text(this.editingContractId === '' ? '写面 · 创建合同（* 必填）' : `写面 · 编辑合同 ${this.editingContractId}（留空字段不动）`)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        TextInput({ placeholder: '* 合同编号', text: this.formCode })
          .width('88%')
          .onChange((v: string) => {
            this.formCode = v;
          })
        TextInput({ placeholder: '* 委托单位', text: this.formClientUnit })
          .width('88%')
          .onChange((v: string) => {
            this.formClientUnit = v;
          })
        TextInput({ placeholder: '* 工程名称', text: this.formProjectName })
          .width('88%')
          .onChange((v: string) => {
            this.formProjectName = v;
          })
        TextInput({ placeholder: '* 施工单位', text: this.formConstructionUnit })
          .width('88%')
          .onChange((v: string) => {
            this.formConstructionUnit = v;
          })
        TextInput({ placeholder: '* 见证单位', text: this.formWitnessUnit })
          .width('88%')
          .onChange((v: string) => {
            this.formWitnessUnit = v;
          })
        TextInput({ placeholder: '* 见证人', text: this.formWitness })
          .width('88%')
          .onChange((v: string) => {
            this.formWitness = v;
          })
        TextInput({ placeholder: '工程所在地点（选填）', text: this.formProjectLocation })
          .width('88%')
          .onChange((v: string) => {
            this.formProjectLocation = v;
          })
        if (this.editingContractId !== '') {
          TextInput({ placeholder: '状态（active/archived，留空不改）', text: this.formStatus })
            .width('88%')
            .onChange((v: string) => {
              this.formStatus = v;
            })
        }
        Row({ space: 12 }) {
          if (this.editingContractId === '') {
            // @entry M02.F01.I03 创建合同
            Button(this.busy ? '创建中…' : '创建合同')
              .enabled(!this.busy)
              .onClick(() => {
                this.submitCreate();
              })
          } else {
            // @entry M02.F01.I04 更新合同（PATCH 语义）
            Button(this.busy ? '保存中…' : '保存更新')
              .enabled(!this.busy)
              .onClick(() => {
                this.submitUpdate();
              })
            Button('取消编辑')
              .enabled(!this.busy)
              .onClick(() => {
                this.resetForm();
              })
          }
        }
        Button(this.busy ? '登出中…' : '登出')
          .width('80%')
          .enabled(!this.busy)
          .onClick(() => {
            this.doLogout();
          })
      }

      if (this.message !== '') {
        Text(this.message)
          .fontSize(13)
          .opacity(0.75)
      }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
  }
}
