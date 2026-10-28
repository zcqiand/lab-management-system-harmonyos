// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { InspectionStandard } from './InspectionStandard';

export interface InspectionDictionaryListStandardsResponse {
  items: Array<InspectionStandard>;
  page: number;
  pageSize: number;
  total: number;
}
