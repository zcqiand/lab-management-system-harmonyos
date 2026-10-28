// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { RequirementComparison } from './RequirementComparison';
import { RequirementJudgmentMode } from './RequirementJudgmentMode';
import { RequirementValueType } from './RequirementValueType';
import { RequirementVerificationStatus } from './RequirementVerificationStatus';

export interface TechnicalRequirement {
  tenantId: string;
  inspectionObjectCode: string;
  inspectionParameterCode: string;
  judgmentStandardCode: string;
  conditions?: string;
  valueType: RequirementValueType;
  minValue?: number;
  maxValue?: number;
  targetValue?: string;
  expression?: string;
  unit?: string;
  comparison: RequirementComparison;
  judgmentMode: RequirementJudgmentMode;
  verificationStatus: RequirementVerificationStatus;
  clause?: string;
  sourcePage?: number;
  sourceHash?: string;
  brand?: string;
  model?: string;
  grade?: string;
  spec?: string;
  sieve?: string;
  remark?: string;
  sortOrder: number;
  createdAt: string;
  updatedAt: string;
}
