// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { InspectionParameterSourceType } from './InspectionParameterSourceType';

export interface InspectionParameter {
  code: string;
  name: string;
  rawName: string;
  canonicalName: string;
  methodText?: string;
  aliases: Array<string>;
  unit?: string;
  sourceType: InspectionParameterSourceType;
  sortOrder: number;
  createdAt: string;
  updatedAt: string;
}
