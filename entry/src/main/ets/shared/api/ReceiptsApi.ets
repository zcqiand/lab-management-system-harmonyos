// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { AssignTaskRequest } from '../models/AssignTaskRequest';
import { CreateSampleReceiptRequest } from '../models/CreateSampleReceiptRequest';
import { FlowActionRequest } from '../models/FlowActionRequest';
import { FlowStatus } from '../models/FlowStatus';
import { ReceiptsActFlowApproveResponse } from '../models/ReceiptsActFlowApproveResponse';
import { ReceiptsActFlowArchivedResponse } from '../models/ReceiptsActFlowArchivedResponse';
import { ReceiptsActFlowAssigningResponse } from '../models/ReceiptsActFlowAssigningResponse';
import { ReceiptsActFlowDataEntryResponse } from '../models/ReceiptsActFlowDataEntryResponse';
import { ReceiptsActFlowIssuanceResponse } from '../models/ReceiptsActFlowIssuanceResponse';
import { ReceiptsActFlowReceivingResponse } from '../models/ReceiptsActFlowReceivingResponse';
import { ReceiptsActFlowReviewResponse } from '../models/ReceiptsActFlowReviewResponse';
import { ReceiptsGetReceiptHistoryResponse } from '../models/ReceiptsGetReceiptHistoryResponse';
import { ReceiptsListReceiptsResponse } from '../models/ReceiptsListReceiptsResponse';
import { SampleReceipt } from '../models/SampleReceipt';
import { UpdateSampleReceiptRequest } from '../models/UpdateSampleReceiptRequest';

export class ReceiptsApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  actFlowApprove(req: FlowActionRequest): Promise<ReceiptsActFlowApproveResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/approve/act`, body: req };
    return this.client.request<ReceiptsActFlowApproveResponse>(options);
  }

  actFlowArchived(req: FlowActionRequest): Promise<ReceiptsActFlowArchivedResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/archived/act`, body: req };
    return this.client.request<ReceiptsActFlowArchivedResponse>(options);
  }

  actFlowAssigning(req: FlowActionRequest): Promise<ReceiptsActFlowAssigningResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/assigning/act`, body: req };
    return this.client.request<ReceiptsActFlowAssigningResponse>(options);
  }

  actFlowDataEntry(req: FlowActionRequest): Promise<ReceiptsActFlowDataEntryResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/data-entry/act`, body: req };
    return this.client.request<ReceiptsActFlowDataEntryResponse>(options);
  }

  actFlowIssuance(req: FlowActionRequest): Promise<ReceiptsActFlowIssuanceResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/issuance/act`, body: req };
    return this.client.request<ReceiptsActFlowIssuanceResponse>(options);
  }

  actFlowReceiving(req: FlowActionRequest): Promise<ReceiptsActFlowReceivingResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/receiving/act`, body: req };
    return this.client.request<ReceiptsActFlowReceivingResponse>(options);
  }

  actFlowReview(req: FlowActionRequest): Promise<ReceiptsActFlowReviewResponse> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts/review/act`, body: req };
    return this.client.request<ReceiptsActFlowReviewResponse>(options);
  }

  assignTask(id: string, req: AssignTaskRequest): Promise<SampleReceipt> {
    let options: RequestOptions = { method: 'PUT', path: `/api/receipts/${id}/task`, body: req };
    return this.client.request<SampleReceipt>(options);
  }

  createReceipt(req: CreateSampleReceiptRequest): Promise<SampleReceipt> {
    let options: RequestOptions = { method: 'POST', path: `/api/receipts`, body: req };
    return this.client.request<SampleReceipt>(options);
  }

  deleteReceipt(id: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/receipts/${id}` };
    return this.client.requestVoid(options);
  }

  getReceipt(id: string): Promise<SampleReceipt> {
    let options: RequestOptions = { method: 'GET', path: `/api/receipts/${id}` };
    return this.client.request<SampleReceipt>(options);
  }

  getReceiptHistory(id: string): Promise<ReceiptsGetReceiptHistoryResponse> {
    let options: RequestOptions = { method: 'GET', path: `/api/receipts/${id}/history` };
    return this.client.request<ReceiptsGetReceiptHistoryResponse>(options);
  }

  listReceipts(page?: number, pageSize?: number, keyword?: string, contractId?: string, flowStatus?: FlowStatus, filter?: string): Promise<ReceiptsListReceiptsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    if (contractId !== undefined) {
      query.set('contractId', String(contractId));
    }
    if (flowStatus !== undefined) {
      query.set('flowStatus', String(flowStatus));
    }
    if (filter !== undefined) {
      query.set('filter', String(filter));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/receipts`, query: query };
    return this.client.request<ReceiptsListReceiptsResponse>(options);
  }

  updateReceipt(id: string, req: UpdateSampleReceiptRequest): Promise<SampleReceipt> {
    let options: RequestOptions = { method: 'PUT', path: `/api/receipts/${id}`, body: req };
    return this.client.request<SampleReceipt>(options);
  }
}
