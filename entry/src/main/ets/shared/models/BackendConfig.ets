// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { AuthHeaderKind } from './AuthHeaderKind';
import { BackendFeatures } from './BackendFeatures';
import { BackendId } from './BackendId';

export interface BackendConfig {
  id: BackendId;
  label: string;
  baseUrl: string;
  authHeader: AuthHeaderKind;
  ssoCallbackPath?: string;
  features: BackendFeatures;
}
