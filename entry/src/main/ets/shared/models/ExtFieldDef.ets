// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ExtFieldDefSource } from './ExtFieldDefSource';
import { ExtFieldDefType } from './ExtFieldDefType';

export interface ExtFieldDef {
  key: string;
  label: string;
  type: ExtFieldDefType;
  required?: boolean;
  options?: Array<string>;
  tag?: string;
  source?: ExtFieldDefSource;
}
