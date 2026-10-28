// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { OAuthGrantType } from './OAuthGrantType';

export interface SsoCallbackRequest {
  grant_type: OAuthGrantType;
  code: string;
  redirect_uri: string;
  state: string;
}
