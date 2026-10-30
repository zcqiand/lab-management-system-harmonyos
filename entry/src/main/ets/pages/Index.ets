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
