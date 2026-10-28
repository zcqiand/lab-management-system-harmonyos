// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CalculationMethod } from '../models/CalculationMethod';
import { CalculationMethodsListCalculationMethodsResponse } from '../models/CalculationMethodsListCalculationMethodsResponse';
import { CreateCalculationMethodRequest } from '../models/CreateCalculationMethodRequest';
import { UpdateCalculationMethodRequest } from '../models/UpdateCalculationMethodRequest';

export class CalculationMethodsApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createCalculationMethod(req: CreateCalculationMethodRequest): Promise<CalculationMethod> {
    let options: RequestOptions = { method: 'POST', path: `/api/calculation-methods`, body: req };
    return this.client.request<CalculationMethod>(options);
  }

  deleteCalculationMethod(inspectionObjectCode: string, inspectionParameterCode: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/calculation-methods/${inspectionObjectCode}/${inspectionParameterCode}` };
    return this.client.requestVoid(options);
  }

  getCalculationMethod(inspectionObjectCode: string, inspectionParameterCode: string): Promise<CalculationMethod> {
    let options: RequestOptions = { method: 'GET', path: `/api/calculation-methods/${inspectionObjectCode}/${inspectionParameterCode}` };
    return this.client.request<CalculationMethod>(options);
  }

  listCalculationMethods(inspectionObjectCode?: string, inspectionParameterCode?: string): Promise<CalculationMethodsListCalculationMethodsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/calculation-methods`, query: query };
    return this.client.request<CalculationMethodsListCalculationMethodsResponse>(options);
  }

  updateCalculationMethod(inspectionObjectCode: string, inspectionParameterCode: string, req: UpdateCalculationMethodRequest): Promise<CalculationMethod> {
    let options: RequestOptions = { method: 'PUT', path: `/api/calculation-methods/${inspectionObjectCode}/${inspectionParameterCode}`, body: req };
    return this.client.request<CalculationMethod>(options);
  }
}
