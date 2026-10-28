// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateParamInterfaceRequest } from '../models/CreateParamInterfaceRequest';
import { ParamInterface } from '../models/ParamInterface';
import { ParamInterfaceLink } from '../models/ParamInterfaceLink';
import { ParamInterfacesListParamInterfaceLinksResponse } from '../models/ParamInterfacesListParamInterfaceLinksResponse';
import { ParamInterfacesListParamInterfacesResponse } from '../models/ParamInterfacesListParamInterfacesResponse';
import { ParamInterfacesUnlinkParamInterfaceRequest } from '../models/ParamInterfacesUnlinkParamInterfaceRequest';
import { UpdateParamInterfaceRequest } from '../models/UpdateParamInterfaceRequest';

export class ParamInterfacesApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createParamInterface(req: CreateParamInterfaceRequest): Promise<ParamInterface> {
    let options: RequestOptions = { method: 'POST', path: `/api/param-interfaces`, body: req };
    return this.client.request<ParamInterface>(options);
  }

  deleteParamInterface(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/param-interfaces/${code}` };
    return this.client.requestVoid(options);
  }

  getParamInterface(code: string): Promise<ParamInterface> {
    let options: RequestOptions = { method: 'GET', path: `/api/param-interfaces/${code}` };
    return this.client.request<ParamInterface>(options);
  }

  linkParamInterface(req: ParamInterfaceLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/param-interfaces/links`, body: req };
    return this.client.requestVoid(options);
  }

  listParamInterfaceLinks(inspectionParameterCode?: string, paramInterfaceCode?: string): Promise<ParamInterfacesListParamInterfaceLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    if (paramInterfaceCode !== undefined) {
      query.set('paramInterfaceCode', String(paramInterfaceCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/param-interfaces/links`, query: query };
    return this.client.request<ParamInterfacesListParamInterfaceLinksResponse>(options);
  }

  listParamInterfaces(page?: number, pageSize?: number, keyword?: string): Promise<ParamInterfacesListParamInterfacesResponse> {
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
    let options: RequestOptions = { method: 'GET', path: `/api/param-interfaces`, query: query };
    return this.client.request<ParamInterfacesListParamInterfacesResponse>(options);
  }

  unlinkParamInterface(req: ParamInterfacesUnlinkParamInterfaceRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/param-interfaces/links`, body: req };
    return this.client.requestVoid(options);
  }

  updateParamInterface(code: string, req: UpdateParamInterfaceRequest): Promise<ParamInterface> {
    let options: RequestOptions = { method: 'PUT', path: `/api/param-interfaces/${code}`, body: req };
    return this.client.request<ParamInterface>(options);
  }
}
