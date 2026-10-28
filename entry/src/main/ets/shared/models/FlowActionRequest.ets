// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { FlowAction } from './FlowAction';

export interface FlowActionRequest {
  ids: Array<string>;
  action: FlowAction;
  operator: string;
  reason?: string;
}
