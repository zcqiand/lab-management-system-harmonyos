// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateTestRecordRequest } from '../models/CreateTestRecordRequest';
import { TestRecord } from '../models/TestRecord';
import { TestRecordsListTestRecordsResponse } from '../models/TestRecordsListTestRecordsResponse';
import { TestRecordsSetVerdictRequest } from '../models/TestRecordsSetVerdictRequest';
import { UpdateTestRecordRequest } from '../models/UpdateTestRecordRequest';

export class TestRecordsApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createTestRecord(req: CreateTestRecordRequest): Promise<TestRecord> {
    let options: RequestOptions = { method: 'POST', path: `/api/test-records`, body: req };
    return this.client.request<TestRecord>(options);
  }

  deleteTestRecord(id: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/test-records/${id}` };
    return this.client.requestVoid(options);
  }

  getTestRecord(id: string): Promise<TestRecord> {
    let options: RequestOptions = { method: 'GET', path: `/api/test-records/${id}` };
    return this.client.request<TestRecord>(options);
  }

  listTestRecords(page?: number, pageSize?: number, sampleId?: string, parameterCode?: string): Promise<TestRecordsListTestRecordsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (sampleId !== undefined) {
      query.set('sampleId', String(sampleId));
    }
    if (parameterCode !== undefined) {
      query.set('parameterCode', String(parameterCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/test-records`, query: query };
    return this.client.request<TestRecordsListTestRecordsResponse>(options);
  }

  setVerdict(id: string, req: TestRecordsSetVerdictRequest): Promise<TestRecord> {
    let options: RequestOptions = { method: 'PATCH', path: `/api/test-records/${id}/verdict`, body: req };
    return this.client.request<TestRecord>(options);
  }

  updateTestRecord(id: string, req: UpdateTestRecordRequest): Promise<TestRecord> {
    let options: RequestOptions = { method: 'PUT', path: `/api/test-records/${id}`, body: req };
    return this.client.request<TestRecord>(options);
  }
}
