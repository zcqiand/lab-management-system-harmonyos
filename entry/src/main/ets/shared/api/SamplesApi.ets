// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateSampleRequest } from '../models/CreateSampleRequest';
import { Sample } from '../models/Sample';
import { SamplesListSamplesResponse } from '../models/SamplesListSamplesResponse';
import { UpdateSampleExtRequest } from '../models/UpdateSampleExtRequest';
import { UpdateSampleRequest } from '../models/UpdateSampleRequest';

export class SamplesApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createSample(req: CreateSampleRequest): Promise<Sample> {
    let options: RequestOptions = { method: 'POST', path: `/api/samples`, body: req };
    return this.client.request<Sample>(options);
  }

  deleteSample(id: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/samples/${id}` };
    return this.client.requestVoid(options);
  }

  getSample(id: string): Promise<Sample> {
    let options: RequestOptions = { method: 'GET', path: `/api/samples/${id}` };
    return this.client.request<Sample>(options);
  }

  listSamples(page?: number, pageSize?: number, receiptId?: string, keyword?: string): Promise<SamplesListSamplesResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (receiptId !== undefined) {
      query.set('receiptId', String(receiptId));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/samples`, query: query };
    return this.client.request<SamplesListSamplesResponse>(options);
  }

  updateSample(id: string, req: UpdateSampleRequest): Promise<Sample> {
    let options: RequestOptions = { method: 'PUT', path: `/api/samples/${id}`, body: req };
    return this.client.request<Sample>(options);
  }

  updateSampleExt(id: string, req: UpdateSampleExtRequest): Promise<Sample> {
    let options: RequestOptions = { method: 'PUT', path: `/api/samples/${id}/ext`, body: req };
    return this.client.request<Sample>(options);
  }
}
