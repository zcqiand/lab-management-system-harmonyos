// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { Contract } from '../models/Contract';
import { ContractStatus } from '../models/ContractStatus';
import { ContractsListContractsResponse } from '../models/ContractsListContractsResponse';
import { CreateContractRequest } from '../models/CreateContractRequest';
import { UpdateContractRequest } from '../models/UpdateContractRequest';

export class ContractsApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createContract(req: CreateContractRequest): Promise<Contract> {
    let options: RequestOptions = { method: 'POST', path: `/api/contracts`, body: req };
    return this.client.request<Contract>(options);
  }

  deleteContract(id: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/contracts/${id}` };
    return this.client.requestVoid(options);
  }

  getContract(id: string): Promise<Contract> {
    let options: RequestOptions = { method: 'GET', path: `/api/contracts/${id}` };
    return this.client.request<Contract>(options);
  }

  listContracts(page?: number, pageSize?: number, keyword?: string, status?: ContractStatus): Promise<ContractsListContractsResponse> {
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
    if (status !== undefined) {
      query.set('status', String(status));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/contracts`, query: query };
    return this.client.request<ContractsListContractsResponse>(options);
  }

  updateContract(id: string, req: UpdateContractRequest): Promise<Contract> {
    let options: RequestOptions = { method: 'PUT', path: `/api/contracts/${id}`, body: req };
    return this.client.request<Contract>(options);
  }
}
