// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { DashboardStats } from '../models/DashboardStats';
import { SummaryData } from '../models/SummaryData';

export class SummaryApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  getDashboardStats(): Promise<DashboardStats> {
    let options: RequestOptions = { method: 'GET', path: `/api/summary/stats` };
    return this.client.request<DashboardStats>(options);
  }

  getReportSummary(categoryCode?: string, dateFrom?: string, dateTo?: string): Promise<SummaryData> {
    let query: Map<string, string> = new Map<string, string>();
    if (categoryCode !== undefined) {
      query.set('categoryCode', String(categoryCode));
    }
    if (dateFrom !== undefined) {
      query.set('dateFrom', String(dateFrom));
    }
    if (dateTo !== undefined) {
      query.set('dateTo', String(dateTo));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/summary`, query: query };
    return this.client.request<SummaryData>(options);
  }
}
