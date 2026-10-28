// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

export interface UpdateParamInterfaceRequest {
  name?: string;
  componentPath?: string;
  description?: string;
  isOfficial?: boolean;
  sortOrder?: number;
  config?: Map<string, string>;
}
