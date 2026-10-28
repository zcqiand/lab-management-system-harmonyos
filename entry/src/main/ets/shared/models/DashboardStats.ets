// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

export interface DashboardStats {
  contractCount: number;
  receiptCount: number;
  sampleCount: number;
  reportCountByStatus: Map<string, string>;
  pendingTaskCount: number;
  todayTestCount: number;
  qualifiedRateByMaterial: Map<string, string>;
  reportOutputByStatus: Map<string, string>;
  funnelByStage: Map<string, string>;
}
