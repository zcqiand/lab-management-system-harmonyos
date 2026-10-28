// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { TokenStorageKeysAccessToken } from './TokenStorageKeysAccessToken';
import { TokenStorageKeysActiveTenantId } from './TokenStorageKeysActiveTenantId';
import { TokenStorageKeysPermissionsCache } from './TokenStorageKeysPermissionsCache';
import { TokenStorageKeysRefreshToken } from './TokenStorageKeysRefreshToken';

export interface TokenStorageKeys {
  accessToken: TokenStorageKeysAccessToken;
  refreshToken: TokenStorageKeysRefreshToken;
  activeTenantId: TokenStorageKeysActiveTenantId;
  permissionsCache: TokenStorageKeysPermissionsCache;
}
