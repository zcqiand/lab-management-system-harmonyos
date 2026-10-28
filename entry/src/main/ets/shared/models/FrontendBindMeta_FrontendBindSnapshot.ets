// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { AuthContext } from './AuthContext';
import { BackendRegistry } from './BackendRegistry';
import { TokenStorageKeys } from './TokenStorageKeys';

export interface FrontendBindMeta_FrontendBindSnapshot {
  registry: BackendRegistry;
  authContext: AuthContext;
  tokenKeys: TokenStorageKeys;
}
