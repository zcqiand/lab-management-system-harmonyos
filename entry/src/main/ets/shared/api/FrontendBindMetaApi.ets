// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { FrontendBindMeta_FrontendBindSnapshot } from '../models/FrontendBindMeta_FrontendBindSnapshot';

export class FrontendBindMetaApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  getFrontendBindSnapshot(): Promise<FrontendBindMeta_FrontendBindSnapshot> {
    let options: RequestOptions = { method: 'GET', path: `/api/_frontend-bind/snapshot` };
    return this.client.request<FrontendBindMeta_FrontendBindSnapshot>(options);
  }
}
