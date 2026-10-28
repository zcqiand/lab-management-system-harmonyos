// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { BackendConfig } from './BackendConfig';
import { BackendId } from './BackendId';

export interface BackendRegistry {
  active: BackendId;
  available: Array<BackendConfig>;
}
