// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

export interface UpdateInspectionObjectRequest {
  inspectionSpecialtyCode?: string;
  sourceProjectNo?: string;
  sourceProjectName?: string;
  name?: string;
  isOptionalForQualification?: boolean;
  isOfficial?: boolean;
  enabled?: boolean;
  sortOrder?: number;
}
