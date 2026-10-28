// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { CalculationAlgorithmType } from './CalculationAlgorithmType';

export interface UpdateCalculationMethodRequest {
  testingStandardCode?: string;
  reportNameCode?: string;
  algorithmType?: CalculationAlgorithmType;
  specimenCount?: number;
  formula?: string;
  conditions?: string;
  roundingRule?: string;
  remark?: string;
  sortOrder?: number;
}
