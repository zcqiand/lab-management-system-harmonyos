// 会话装配（runtime 接线面，不进本地单测——本文件 import runtime/@ohos）。
//   - base URL 走 AppConfig.parseApiBaseUrl（rawfile config.json，fail-fast 禁兜底）
//   - lab 原生登录（AuthApi.login）由后端代理 saas IdP（AuthService：密码路径走服务账号登 saas），
//     本仓无 clientId 面；SSO 回调链后置（家族档案：SSO 形态 Phase 1+）
import { ApiClient } from 'harmonyos-api-runtime';
import {
  AuthApi, CatalogApi, ReportNamesApi, CalculationMethodsApi, TechnicalRequirementsApi
} from '../shared';
import { CatalogListBrandsResponse } from '../shared/models/CatalogListBrandsResponse';
import { ReportNamesListReportNamesResponse } from '../shared/models/ReportNamesListReportNamesResponse';
import { CalculationMethodsListCalculationMethodsResponse } from '../shared/models/CalculationMethodsListCalculationMethodsResponse';
import { TechnicalRequirementsListTechnicalRequirementsResponse } from '../shared/models/TechnicalRequirementsListTechnicalRequirementsResponse';
import { parseApiBaseUrl } from '../config/AppConfig';
import { SessionState, MemoryTokenStore } from './SessionState';

export class Session {
  private readonly state: SessionState;
  private authApi: AuthApi | null = null;
  private catalogApi: CatalogApi | null = null;
  private reportNamesApi: ReportNamesApi | null = null;
  private calculationMethodsApi: CalculationMethodsApi | null = null;
  private technicalRequirementsApi: TechnicalRequirementsApi | null = null;

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
