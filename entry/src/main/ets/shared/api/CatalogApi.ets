// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CatalogListBrandsResponse } from '../models/CatalogListBrandsResponse';
import { CatalogListGradesResponse } from '../models/CatalogListGradesResponse';
import { CatalogListModelsResponse } from '../models/CatalogListModelsResponse';
import { CatalogListSpecsResponse } from '../models/CatalogListSpecsResponse';
import { CreateCatalogEntryRequest } from '../models/CreateCatalogEntryRequest';
import { InspectionBrand } from '../models/InspectionBrand';
import { InspectionGrade } from '../models/InspectionGrade';
import { InspectionModel } from '../models/InspectionModel';
import { InspectionSpec } from '../models/InspectionSpec';
import { UpdateCatalogEntryRequest } from '../models/UpdateCatalogEntryRequest';

export class CatalogApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createBrand(req: CreateCatalogEntryRequest): Promise<InspectionBrand> {
    let options: RequestOptions = { method: 'POST', path: `/api/catalog/brands`, body: req };
    return this.client.request<InspectionBrand>(options);
  }

  createGrade(req: CreateCatalogEntryRequest): Promise<InspectionGrade> {
    let options: RequestOptions = { method: 'POST', path: `/api/catalog/grades`, body: req };
    return this.client.request<InspectionGrade>(options);
  }

  createModel(req: CreateCatalogEntryRequest): Promise<InspectionModel> {
    let options: RequestOptions = { method: 'POST', path: `/api/catalog/models`, body: req };
    return this.client.request<InspectionModel>(options);
  }

  createSpec(req: CreateCatalogEntryRequest): Promise<InspectionSpec> {
    let options: RequestOptions = { method: 'POST', path: `/api/catalog/specs`, body: req };
    return this.client.request<InspectionSpec>(options);
  }

  deleteBrand(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/catalog/brands/${code}` };
    return this.client.requestVoid(options);
  }

  deleteGrade(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/catalog/grades/${code}` };
    return this.client.requestVoid(options);
  }

  deleteModel(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/catalog/models/${code}` };
    return this.client.requestVoid(options);
  }

  deleteSpec(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/catalog/specs/${code}` };
    return this.client.requestVoid(options);
  }

  listBrands(page?: number, pageSize?: number, inspectionObjectCode?: string, keyword?: string): Promise<CatalogListBrandsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/catalog/brands`, query: query };
    return this.client.request<CatalogListBrandsResponse>(options);
  }

  listGrades(page?: number, pageSize?: number, inspectionObjectCode?: string, keyword?: string): Promise<CatalogListGradesResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/catalog/grades`, query: query };
    return this.client.request<CatalogListGradesResponse>(options);
  }

  listModels(page?: number, pageSize?: number, inspectionObjectCode?: string, keyword?: string): Promise<CatalogListModelsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/catalog/models`, query: query };
    return this.client.request<CatalogListModelsResponse>(options);
  }

  listSpecs(page?: number, pageSize?: number, inspectionObjectCode?: string, keyword?: string): Promise<CatalogListSpecsResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (page !== undefined) {
      query.set('page', String(page));
    }
    if (pageSize !== undefined) {
      query.set('pageSize', String(pageSize));
    }
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (keyword !== undefined) {
      query.set('keyword', String(keyword));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/catalog/specs`, query: query };
    return this.client.request<CatalogListSpecsResponse>(options);
  }

  updateBrand(code: string, req: UpdateCatalogEntryRequest): Promise<InspectionBrand> {
    let options: RequestOptions = { method: 'PUT', path: `/api/catalog/brands/${code}`, body: req };
    return this.client.request<InspectionBrand>(options);
  }

  updateGrade(code: string, req: UpdateCatalogEntryRequest): Promise<InspectionGrade> {
    let options: RequestOptions = { method: 'PUT', path: `/api/catalog/grades/${code}`, body: req };
    return this.client.request<InspectionGrade>(options);
  }

  updateModel(code: string, req: UpdateCatalogEntryRequest): Promise<InspectionModel> {
    let options: RequestOptions = { method: 'PUT', path: `/api/catalog/models/${code}`, body: req };
    return this.client.request<InspectionModel>(options);
  }

  updateSpec(code: string, req: UpdateCatalogEntryRequest): Promise<InspectionSpec> {
    let options: RequestOptions = { method: 'PUT', path: `/api/catalog/specs/${code}`, body: req };
    return this.client.request<InspectionSpec>(options);
  }
}
