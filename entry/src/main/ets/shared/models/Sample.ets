// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

export interface Sample {
  id: string;
  tenantId: string;
  receiptId: string;
  sampleCode: string;
  sampleName?: string;
  model?: string;
  specification?: string;
  grade?: string;
  brand?: string;
  manufacturer?: string;
  structuralPart?: string;
  representQuantity?: string;
  sampleQuantity?: string;
  batchNumber?: string;
  supplyUnit?: string;
  arrivalDate?: string;
  samplingDate?: string;
  curingCondition?: string;
  age?: string;
  ext: Map<string, string>;
  remark?: string;
  createdAt: string;
  updatedAt: string;
}
