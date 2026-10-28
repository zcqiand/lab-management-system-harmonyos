// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { FlowHistoryEntry } from './FlowHistoryEntry';
import { FlowStatus } from './FlowStatus';
import { ReceiptResult } from './ReceiptResult';

export interface SampleReceipt {
  id: string;
  tenantId: string;
  contractId: string;
  commissionCode: string;
  commissionDate: string;
  commissionRegisterCode?: string;
  commissionRegisterDate?: string;
  categoryCode: string;
  projectName?: string;
  clientUnit?: string;
  buildingUnit?: string;
  supervisorUnit?: string;
  constructionUnit?: string;
  witnessUnit?: string;
  samplingLocation?: string;
  witness?: string;
  witnessPhone?: string;
  inspector?: string;
  inspectorPhone?: string;
  receivedBy: string;
  sampleSource: string;
  testCategory: string;
  testEnvironment?: string;
  mainEquipment?: string;
  testOperator?: string;
  testStartDate?: string;
  testEndDate?: string;
  originalRecordNo?: string;
  remark?: string;
  judgmentBasis?: Array<string>;
  testingBasis?: Array<string>;
  testParameters?: Array<string>;
  flowStatus: FlowStatus;
  flowHistory: Array<FlowHistoryEntry>;
  lastSubmittedBy?: string;
  assigneeId?: string;
  assigneeName?: string;
  plannedTestDate?: string;
  reportCode?: string;
  reportDate?: string;
  conclusion?: string;
  result?: ReceiptResult;
  issuedAt?: string;
  createdAt: string;
  updatedAt: string;
}
