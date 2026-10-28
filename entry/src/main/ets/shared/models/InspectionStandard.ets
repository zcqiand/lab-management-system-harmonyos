// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { InspectionStandardStatus } from './InspectionStandardStatus';

export interface InspectionStandard {
  code: string;
  name: string;
  version?: string;
  status: InspectionStandardStatus;
  sourceDocumentId?: string;
  sourceHash?: string;
  sortOrder: number;
  createdAt: string;
  updatedAt: string;
}
