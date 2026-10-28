// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { AuthGetMenusResponse } from '../models/AuthGetMenusResponse';
import { AuthLogoutRequest } from '../models/AuthLogoutRequest';
import { CurrentUserSession } from '../models/CurrentUserSession';
import { LoginRequest } from '../models/LoginRequest';
import { LoginResponse } from '../models/LoginResponse';
import { OAuthResponseType } from '../models/OAuthResponseType';
import { PermissionSet } from '../models/PermissionSet';
import { RefreshTokenRequest } from '../models/RefreshTokenRequest';
import { SsoCallbackRequest } from '../models/SsoCallbackRequest';
import { SsoRedirect } from '../models/SsoRedirect';
import { SwitchTenantRequest } from '../models/SwitchTenantRequest';

export class AuthApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  getCurrentUser(): Promise<CurrentUserSession> {
    let options: RequestOptions = { method: 'GET', path: `/api/auth/me` };
    return this.client.request<CurrentUserSession>(options);
  }

  getMenus(): Promise<AuthGetMenusResponse> {
    let options: RequestOptions = { method: 'GET', path: `/api/auth/menus` };
    return this.client.request<AuthGetMenusResponse>(options);
  }

  getPermissions(): Promise<PermissionSet> {
    let options: RequestOptions = { method: 'GET', path: `/api/auth/permissions` };
    return this.client.request<PermissionSet>(options);
  }

  login(req: LoginRequest): Promise<LoginResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/login`, body: req };
    return this.client.request<LoginResponse>(options);
  }

  logout(req: AuthLogoutRequest): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/logout`, body: req };
    return this.client.requestVoid(options);
  }

  nativeLogin(req: LoginRequest): Promise<LoginResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/native-login`, body: req };
    return this.client.request<LoginResponse>(options);
  }

  refresh(req: RefreshTokenRequest): Promise<LoginResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/refresh`, body: req };
    return this.client.request<LoginResponse>(options);
  }

  ssoAuthorize(response_type: OAuthResponseType, client_id: string, redirect_uri: string, state: string): Promise<SsoRedirect> {
    let query: Map<string, string> = new Map<string, string>();
    if (response_type !== undefined) {
      query.set('response_type', String(response_type));
    }
    if (client_id !== undefined) {
      query.set('client_id', String(client_id));
    }
    if (redirect_uri !== undefined) {
      query.set('redirect_uri', String(redirect_uri));
    }
    if (state !== undefined) {
      query.set('state', String(state));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/auth/sso/authorize`, query: query };
    return this.client.request<SsoRedirect>(options);
  }

  ssoCallback(req: SsoCallbackRequest): Promise<LoginResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/sso/callback`, body: req };
    return this.client.request<LoginResponse>(options);
  }

  switchTenant(req: SwitchTenantRequest): Promise<LoginResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/auth/switch-tenant`, body: req };
    return this.client.request<LoginResponse>(options);
  }
}
