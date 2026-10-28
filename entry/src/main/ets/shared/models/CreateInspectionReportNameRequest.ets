// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ExtFieldDef } from './ExtFieldDef';

export interface CreateInspectionReportNameRequest {
  code: string;
  name: string;
  fullName?: string;
  templatePath?: string;
  summaryName?: string;
  extFields?: Array<ExtFieldDef>;
  description?: string;
  sortOrder?: number;
}
