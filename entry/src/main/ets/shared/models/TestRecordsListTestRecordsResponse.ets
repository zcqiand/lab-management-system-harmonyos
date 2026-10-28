// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { TestRecord } from './TestRecord';

export interface TestRecordsListTestRecordsResponse {
  items: Array<TestRecord>;
  page: number;
  pageSize: number;
  total: number;
}
