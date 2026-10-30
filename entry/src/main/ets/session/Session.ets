// 会话装配（runtime 接线面，不进本地单测——本文件 import runtime/@ohos）。
//   - base URL 走 AppConfig.parseApiBaseUrl（rawfile config.json，fail-fast 禁兜底）
//   - lab 原生登录（AuthApi.login）由后端代理 saas IdP（AuthService：密码路径走服务账号登 saas），
//     本仓无 clientId 面；SSO 回调链后置（家族档案：SSO 形态 Phase 1+）
import { ApiClient } from 'harmonyos-api-runtime';
import {
  AuthApi, CatalogApi, ReportNamesApi, CalculationMethodsApi, TechnicalRequirementsApi,
  InspectionDictionaryApi, ParamInterfacesApi, ContractsApi, ReceiptsApi, SamplesApi,
  TestRecordsApi, SummaryApi
} from '../shared';
import { CatalogListBrandsResponse } from '../shared/models/CatalogListBrandsResponse';
import { ReportNamesListReportNamesResponse } from '../shared/models/ReportNamesListReportNamesResponse';
import { CalculationMethodsListCalculationMethodsResponse } from '../shared/models/CalculationMethodsListCalculationMethodsResponse';
import { TechnicalRequirementsListTechnicalRequirementsResponse } from '../shared/models/TechnicalRequirementsListTechnicalRequirementsResponse';
import { InspectionDictionaryListObjectsResponse } from '../shared/models/InspectionDictionaryListObjectsResponse';
import { InspectionDictionaryListParametersResponse } from '../shared/models/InspectionDictionaryListParametersResponse';
import { InspectionDictionaryListSpecialtiesResponse } from '../shared/models/InspectionDictionaryListSpecialtiesResponse';
import { InspectionDictionaryListStandardsResponse } from '../shared/models/InspectionDictionaryListStandardsResponse';
import { ParamInterfacesListParamInterfacesResponse } from '../shared/models/ParamInterfacesListParamInterfacesResponse';
import { ContractsListContractsResponse } from '../shared/models/ContractsListContractsResponse';
import { ReceiptsListReceiptsResponse } from '../shared/models/ReceiptsListReceiptsResponse';
import { SamplesListSamplesResponse } from '../shared/models/SamplesListSamplesResponse';
import { TestRecordsListTestRecordsResponse } from '../shared/models/TestRecordsListTestRecordsResponse';
import { DashboardStats } from '../shared/models/DashboardStats';
import { SummaryData } from '../shared/models/SummaryData';
import { Contract } from '../shared/models/Contract';
import { CreateContractRequest } from '../shared/models/CreateContractRequest';
import { UpdateContractRequest } from '../shared/models/UpdateContractRequest';
import { assembleCreateContract, assembleUpdateContract, ensureContractId, ContractForm } from '../forms/ContractForms';
import { parseApiBaseUrl } from '../config/AppConfig';
import { SessionState, MemoryTokenStore } from './SessionState';

export class Session {
  private readonly state: SessionState;
  private authApi: AuthApi | null = null;
  private catalogApi: CatalogApi | null = null;
  private reportNamesApi: ReportNamesApi | null = null;
  private calculationMethodsApi: CalculationMethodsApi | null = null;
  private technicalRequirementsApi: TechnicalRequirementsApi | null = null;
  private inspectionDictionaryApi: InspectionDictionaryApi | null = null;
  private paramInterfacesApi: ParamInterfacesApi | null = null;
  private contractsApi: ContractsApi | null = null;
  private receiptsApi: ReceiptsApi | null = null;
  private samplesApi: SamplesApi | null = null;
  private testRecordsApi: TestRecordsApi | null = null;
  private summaryApi: SummaryApi | null = null;

  constructor() {
    this.state = new SessionState(new MemoryTokenStore());
  }

  // rawfile config.json 原文进，fail-fast 解析（API_BASE_URL 缺失即抛）
  configure(rawConfig: string): void {
    const baseUrl = parseApiBaseUrl(rawConfig);
    const client = new ApiClient(baseUrl, () => this.state.tokenProvider());
    this.authApi = new AuthApi(client);
    this.catalogApi = new CatalogApi(client);
    this.reportNamesApi = new ReportNamesApi(client);
    this.calculationMethodsApi = new CalculationMethodsApi(client);
    this.technicalRequirementsApi = new TechnicalRequirementsApi(client);
    this.inspectionDictionaryApi = new InspectionDictionaryApi(client);
    this.paramInterfacesApi = new ParamInterfacesApi(client);
    this.contractsApi = new ContractsApi(client);
    this.receiptsApi = new ReceiptsApi(client);
    this.samplesApi = new SamplesApi(client);
    this.testRecordsApi = new TestRecordsApi(client);
    this.summaryApi = new SummaryApi(client);
  }

  private requireAuth(): AuthApi {
    if (this.authApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.authApi;
  }

  private requireCatalog(): CatalogApi {
    if (this.catalogApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.catalogApi;
  }

  private requireReportNames(): ReportNamesApi {
    if (this.reportNamesApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.reportNamesApi;
  }

  private requireCalculationMethods(): CalculationMethodsApi {
    if (this.calculationMethodsApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.calculationMethodsApi;
  }

  private requireTechnicalRequirements(): TechnicalRequirementsApi {
    if (this.technicalRequirementsApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.technicalRequirementsApi;
  }

  private requireInspectionDictionary(): InspectionDictionaryApi {
    if (this.inspectionDictionaryApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.inspectionDictionaryApi;
  }

  private requireParamInterfaces(): ParamInterfacesApi {
    if (this.paramInterfacesApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.paramInterfacesApi;
  }

  private requireContracts(): ContractsApi {
    if (this.contractsApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.contractsApi;
  }

  private requireReceipts(): ReceiptsApi {
    if (this.receiptsApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.receiptsApi;
  }

  private requireSamples(): SamplesApi {
    if (this.samplesApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.samplesApi;
  }

  private requireTestRecords(): TestRecordsApi {
    if (this.testRecordsApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.testRecordsApi;
  }

  private requireSummary(): SummaryApi {
    if (this.summaryApi === null) {
      throw new Error('Session 未配置（configure 未调用/未完成）——禁静默兜底 base URL');
    }
    return this.summaryApi;
  }

  authenticated(): boolean {
    return this.state.authenticated();
  }

  async login(username: string, password: string): Promise<void> {
    const resp = await this.requireAuth().login({ username: username, password: password });
    this.state.applyLogin(resp);
  }

  listBrands(page: number, pageSize: number): Promise<CatalogListBrandsResponse> {
    return this.requireCatalog().listBrands(page, pageSize);
  }

  // 码表只读区（片2）：lab 分页仅回显不切片（契约 @doc 2026-10-30），page 传 1 即全量
  listReportNames(page: number, pageSize: number): Promise<ReportNamesListReportNamesResponse> {
    return this.requireReportNames().listReportNames(page, pageSize);
  }

  listCalculationMethods(): Promise<CalculationMethodsListCalculationMethodsResponse> {
    return this.requireCalculationMethods().listCalculationMethods(undefined, undefined);
  }

  listTechnicalRequirements(): Promise<TechnicalRequirementsListTechnicalRequirementsResponse> {
    return this.requireTechnicalRequirements().listTechnicalRequirements(undefined, undefined, undefined, undefined);
  }

  // 检测能力只读区（片3）：专业/对象/参数/标准字典四列表 + 参数界面列表，全量回显
  listSpecialties(page: number, pageSize: number): Promise<InspectionDictionaryListSpecialtiesResponse> {
    return this.requireInspectionDictionary().listSpecialties(page, pageSize, undefined);
  }

  listObjects(page: number, pageSize: number): Promise<InspectionDictionaryListObjectsResponse> {
    return this.requireInspectionDictionary().listObjects(page, pageSize, undefined, undefined);
  }

  listParameters(page: number, pageSize: number): Promise<InspectionDictionaryListParametersResponse> {
    return this.requireInspectionDictionary().listParameters(page, pageSize, undefined, undefined);
  }

  listStandards(page: number, pageSize: number): Promise<InspectionDictionaryListStandardsResponse> {
    return this.requireInspectionDictionary().listStandards(page, pageSize, undefined, undefined);
  }

  listParamInterfaces(page: number, pageSize: number): Promise<ParamInterfacesListParamInterfacesResponse> {
    return this.requireParamInterfaces().listParamInterfaces(page, pageSize, undefined);
  }

  // 业务数据只读区（片4）：合同/委托/样品/记录四列表，回显分页全量
  listContracts(page: number, pageSize: number): Promise<ContractsListContractsResponse> {
    return this.requireContracts().listContracts(page, pageSize, undefined, undefined);
  }

  listReceipts(page: number, pageSize: number): Promise<ReceiptsListReceiptsResponse> {
    return this.requireReceipts().listReceipts(page, pageSize, undefined, undefined, undefined, undefined);
  }

  listSamples(page: number, pageSize: number): Promise<SamplesListSamplesResponse> {
    return this.requireSamples().listSamples(page, pageSize, undefined, undefined);
  }

  listTestRecords(page: number, pageSize: number): Promise<TestRecordsListTestRecordsResponse> {
    return this.requireTestRecords().listTestRecords(page, pageSize, undefined, undefined);
  }

  // 汇总只读区（片5）：仪表盘计数 + 报表汇总（categoryCode 筛选后置）。
  // FrontendBindMetaApi 不接（frontend-bind.tsp 全表面 @deprecated ADR-0014：runtime
  // 实现已删、springboot 404 实证 2026-10-30、react/vue 消费者 0 import——生成物留
  // 编译覆盖即可，见 EntryAbility 触碰集注释）
  getDashboardStats(): Promise<DashboardStats> {
    return this.requireSummary().getDashboardStats();
  }

  getReportSummary(): Promise<SummaryData> {
    return this.requireSummary().getReportSummary(undefined, undefined, undefined);
  }

  // 合同写流（M02.F01.I03/I04/I05）：表单装配 fail-fast 后走生成 Api
  async createContract(form: ContractForm): Promise<Contract> {
    return this.requireContracts().createContract(assembleCreateContract(form));
  }

  async updateContract(id: string, form: ContractForm): Promise<Contract> {
    return this.requireContracts().updateContract(ensureContractId(id), assembleUpdateContract(form));
  }

  async deleteContract(id: string): Promise<void> {
    await this.requireContracts().deleteContract(ensureContractId(id));
  }

  async logout(): Promise<void> {
    // lab 契约 logout = POST /api/auth/logout（AuthService：服务端无操作、前端清存储语义）——
    // 契约面照走真端点，finally 清本地态；refresh 链后置另切片
    try {
      await this.requireAuth().logout({ token: this.state.tokenProvider() });
    } finally {
      this.state.logout();
    }
  }
}

// 页面级单例（EntryAbility/Index 共用同一会话）
export const session = new Session();
