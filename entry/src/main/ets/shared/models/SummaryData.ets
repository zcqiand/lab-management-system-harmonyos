// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { SummaryColumn } from './SummaryColumn';

export interface SummaryData {
  summaryName: string;
  columns: Array<SummaryColumn>;
  rows: Array<Map<string, string>>;
}
