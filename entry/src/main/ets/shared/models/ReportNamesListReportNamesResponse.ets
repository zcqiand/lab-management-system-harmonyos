// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { InspectionReportName } from './InspectionReportName';

export interface ReportNamesListReportNamesResponse {
  items: Array<InspectionReportName>;
  page: number;
  pageSize: number;
  total: number;
}
