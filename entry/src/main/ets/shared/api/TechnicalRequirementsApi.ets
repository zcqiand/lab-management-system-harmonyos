// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateTechnicalRequirementRequest } from '../models/CreateTechnicalRequirementRequest';
import { RequirementVerificationStatus } from '../models/RequirementVerificationStatus';
import { TechnicalRequirement } from '../models/TechnicalRequirement';
import { TechnicalRequirementsListTechnicalRequirementsResponse } from '../models/TechnicalRequirementsListTechnicalRequirementsResponse';
import { UpdateTechnicalRequirementRequest } from '../models/UpdateTechnicalRequirementRequest';

export class TechnicalRequirementsApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createTechnicalRequirement(req: CreateTechnicalRequirementRequest): Promise<TechnicalRequirement> {
    let options: RequestOptions = { method: 'POST', path: `/api/technical-requirements`, body: req };
    return this.client.request<TechnicalRequirement>(options);
  }

  deleteTechnicalRequirement(inspectionObjectCode: string, inspectionParameterCode: string, judgmentStandardCode: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/technical-requirements/${inspectionObjectCode}/${inspectionParameterCode}/${judgmentStandardCode}` };
    return this.client.requestVoid(options);
  }

  getTechnicalRequirement(inspectionObjectCode: string, inspectionParameterCode: string, judgmentStandardCode: string): Promise<TechnicalRequirement> {
    let options: RequestOptions = { method: 'GET', path: `/api/technical-requirements/${inspectionObjectCode}/${inspectionParameterCode}/${judgmentStandardCode}` };
    return this.client.request<TechnicalRequirement>(options);
  }

  listTechnicalRequirements(inspectionObjectCode?: string, inspectionParameterCode?: string, judgmentStandardCode?: string, verificationStatus?: RequirementVerificationStatus): Promise<TechnicalRequirementsListTechnicalRequirementsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    if (judgmentStandardCode !== undefined) {
      query.set('judgmentStandardCode', String(judgmentStandardCode));
    }
    if (verificationStatus !== undefined) {
      query.set('verificationStatus', String(verificationStatus));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/technical-requirements`, query: query };
    return this.client.request<TechnicalRequirementsListTechnicalRequirementsResponse>(options);
  }

  updateTechnicalRequirement(inspectionObjectCode: string, inspectionParameterCode: string, judgmentStandardCode: string, req: UpdateTechnicalRequirementRequest): Promise<TechnicalRequirement> {
    let options: RequestOptions = { method: 'PUT', path: `/api/technical-requirements/${inspectionObjectCode}/${inspectionParameterCode}/${judgmentStandardCode}`, body: req };
    return this.client.request<TechnicalRequirement>(options);
  }
}
