// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { AuthStateAwaiting_tenantKind } from './AuthStateAwaiting_tenantKind';

export interface AuthStateAwaiting_tenant {
  kind: AuthStateAwaiting_tenantKind;
  value: Map<string, string>;
}
