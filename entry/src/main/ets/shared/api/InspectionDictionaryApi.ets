// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateInspectionObjectRequest } from '../models/CreateInspectionObjectRequest';
import { CreateInspectionParameterRequest } from '../models/CreateInspectionParameterRequest';
import { CreateInspectionSpecialtyRequest } from '../models/CreateInspectionSpecialtyRequest';
import { CreateInspectionStandardRequest } from '../models/CreateInspectionStandardRequest';
import { InspectionDictionaryListObjectParameterLinksResponse } from '../models/InspectionDictionaryListObjectParameterLinksResponse';
import { InspectionDictionaryListObjectStandardLinksResponse } from '../models/InspectionDictionaryListObjectStandardLinksResponse';
import { InspectionDictionaryListObjectsResponse } from '../models/InspectionDictionaryListObjectsResponse';
import { InspectionDictionaryListParametersResponse } from '../models/InspectionDictionaryListParametersResponse';
import { InspectionDictionaryListSpecialtiesResponse } from '../models/InspectionDictionaryListSpecialtiesResponse';
import { InspectionDictionaryListSpecialtyObjectLinksResponse } from '../models/InspectionDictionaryListSpecialtyObjectLinksResponse';
import { InspectionDictionaryListStandardParameterLinksResponse } from '../models/InspectionDictionaryListStandardParameterLinksResponse';
import { InspectionDictionaryListStandardsResponse } from '../models/InspectionDictionaryListStandardsResponse';
import { InspectionDictionaryUnlinkObjectParameterRequest } from '../models/InspectionDictionaryUnlinkObjectParameterRequest';
import { InspectionDictionaryUnlinkObjectStandardRequest } from '../models/InspectionDictionaryUnlinkObjectStandardRequest';
import { InspectionObject } from '../models/InspectionObject';
import { InspectionParameter } from '../models/InspectionParameter';
import { InspectionParameterSourceType } from '../models/InspectionParameterSourceType';
import { InspectionSpecialty } from '../models/InspectionSpecialty';
import { InspectionStandard } from '../models/InspectionStandard';
import { InspectionStandardRole } from '../models/InspectionStandardRole';
import { InspectionStandardStatus } from '../models/InspectionStandardStatus';
import { ObjectParameterLink } from '../models/ObjectParameterLink';
import { ObjectStandardLink } from '../models/ObjectStandardLink';
import { SpecialtyObjectLink } from '../models/SpecialtyObjectLink';
import { StandardParameterLink } from '../models/StandardParameterLink';
import { UpdateInspectionObjectRequest } from '../models/UpdateInspectionObjectRequest';
import { UpdateInspectionParameterRequest } from '../models/UpdateInspectionParameterRequest';
import { UpdateInspectionSpecialtyRequest } from '../models/UpdateInspectionSpecialtyRequest';
import { UpdateInspectionStandardRequest } from '../models/UpdateInspectionStandardRequest';

export class InspectionDictionaryApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createObject(req: CreateInspectionObjectRequest): Promise<InspectionObject> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/objects`, body: req };
    return this.client.request<InspectionObject>(options);
  }

  createParameter(req: CreateInspectionParameterRequest): Promise<InspectionParameter> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/parameters`, body: req };
    return this.client.request<InspectionParameter>(options);
  }

  createSpecialty(req: CreateInspectionSpecialtyRequest): Promise<InspectionSpecialty> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/specialties`, body: req };
    return this.client.request<InspectionSpecialty>(options);
  }

  createStandard(req: CreateInspectionStandardRequest): Promise<InspectionStandard> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/standards`, body: req };
    return this.client.request<InspectionStandard>(options);
  }

  deleteObject(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/objects/${code}` };
    return this.client.requestVoid(options);
  }

  deleteParameter(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/parameters/${code}` };
    return this.client.requestVoid(options);
  }

  deleteSpecialty(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/specialties/${code}` };
    return this.client.requestVoid(options);
  }

  deleteStandard(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/standards/${code}` };
    return this.client.requestVoid(options);
  }

  linkObjectParameter(req: ObjectParameterLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/links/object-parameter`, body: req };
    return this.client.requestVoid(options);
  }

  linkObjectStandard(req: ObjectStandardLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/links/object-standard`, body: req };
    return this.client.requestVoid(options);
  }

  linkSpecialtyObject(req: SpecialtyObjectLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/links/specialty-object`, body: req };
    return this.client.requestVoid(options);
  }

  linkStandardParameter(req: StandardParameterLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/inspection/links/standard-parameter`, body: req };
    return this.client.requestVoid(options);
  }

  listObjectParameterLinks(inspectionObjectCode?: string, inspectionParameterCode?: string): Promise<InspectionDictionaryListObjectParameterLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/links/object-parameter`, query: query };
    return this.client.request<InspectionDictionaryListObjectParameterLinksResponse>(options);
  }

  listObjectStandardLinks(inspectionObjectCode?: string, role?: InspectionStandardRole): Promise<InspectionDictionaryListObjectStandardLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (role !== undefined) {
      query.set('role', String(role));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/links/object-standard`, query: query };
    return this.client.request<InspectionDictionaryListObjectStandardLinksResponse>(options);
  }

  listObjects(page?: number, pageSize?: number, inspectionSpecialtyCode?: string, keyword?: string): Promise<InspectionDictionaryListObjectsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (inspectionSpecialtyCode !== undefined) {
      query.set('inspectionSpecialtyCode', String(inspectionSpecialtyCode));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/objects`, query: query };
    return this.client.request<InspectionDictionaryListObjectsResponse>(options);
  }

  listParameters(page?: number, pageSize?: number, keyword?: string, sourceType?: InspectionParameterSourceType): Promise<InspectionDictionaryListParametersResponse> {
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
    if (sourceType !== undefined) {
      query.set('sourceType', String(sourceType));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/parameters`, query: query };
    return this.client.request<InspectionDictionaryListParametersResponse>(options);
  }

  listSpecialties(page?: number, pageSize?: number, keyword?: string): Promise<InspectionDictionaryListSpecialtiesResponse> {
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
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/specialties`, query: query };
    return this.client.request<InspectionDictionaryListSpecialtiesResponse>(options);
  }

  listSpecialtyObjectLinks(inspectionSpecialtyCode?: string): Promise<InspectionDictionaryListSpecialtyObjectLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionSpecialtyCode !== undefined) {
      query.set('inspectionSpecialtyCode', String(inspectionSpecialtyCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/links/specialty-object`, query: query };
    return this.client.request<InspectionDictionaryListSpecialtyObjectLinksResponse>(options);
  }

  listStandardParameterLinks(inspectionStandardCode?: string, inspectionParameterCode?: string): Promise<InspectionDictionaryListStandardParameterLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionStandardCode !== undefined) {
      query.set('inspectionStandardCode', String(inspectionStandardCode));
    }
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/links/standard-parameter`, query: query };
    return this.client.request<InspectionDictionaryListStandardParameterLinksResponse>(options);
  }

  listStandards(page?: number, pageSize?: number, keyword?: string, status?: InspectionStandardStatus): Promise<InspectionDictionaryListStandardsResponse> {
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
    let options: RequestOptions = { method: 'GET', path: `/api/inspection/standards`, query: query };
    return this.client.request<InspectionDictionaryListStandardsResponse>(options);
  }

  unlinkObjectParameter(req: InspectionDictionaryUnlinkObjectParameterRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/links/object-parameter`, body: req };
    return this.client.requestVoid(options);
  }

  unlinkObjectStandard(req: InspectionDictionaryUnlinkObjectStandardRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/links/object-standard`, body: req };
    return this.client.requestVoid(options);
  }

  unlinkSpecialtyObject(req: SpecialtyObjectLink): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/links/specialty-object`, body: req };
    return this.client.requestVoid(options);
  }

  unlinkStandardParameter(req: StandardParameterLink): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/inspection/links/standard-parameter`, body: req };
    return this.client.requestVoid(options);
  }

  updateObject(code: string, req: UpdateInspectionObjectRequest): Promise<InspectionObject> {
    let options: RequestOptions = { method: 'PUT', path: `/api/inspection/objects/${code}`, body: req };
    return this.client.request<InspectionObject>(options);
  }

  updateParameter(code: string, req: UpdateInspectionParameterRequest): Promise<InspectionParameter> {
    let options: RequestOptions = { method: 'PUT', path: `/api/inspection/parameters/${code}`, body: req };
    return this.client.request<InspectionParameter>(options);
  }

  updateSpecialty(code: string, req: UpdateInspectionSpecialtyRequest): Promise<InspectionSpecialty> {
    let options: RequestOptions = { method: 'PUT', path: `/api/inspection/specialties/${code}`, body: req };
    return this.client.request<InspectionSpecialty>(options);
  }

  updateStandard(code: string, req: UpdateInspectionStandardRequest): Promise<InspectionStandard> {
    let options: RequestOptions = { method: 'PUT', path: `/api/inspection/standards/${code}`, body: req };
    return this.client.request<InspectionStandard>(options);
  }
}
