// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ReportNameParameterLink } from './ReportNameParameterLink';

export interface ReportNamesListReportNameParameterLinksResponse {
  items: Array<ReportNameParameterLink>;
  page: number;
  pageSize: number;
  total: number;
}
