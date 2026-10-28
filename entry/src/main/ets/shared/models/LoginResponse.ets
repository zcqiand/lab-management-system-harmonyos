// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { CurrentUser } from './CurrentUser';
import { MyTenant } from './MyTenant';

export interface LoginResponse {
  token: string;
  refreshToken?: string;
  user: CurrentUser;
  tenants: Array<MyTenant>;
}
