// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ApiClient, RequestOptions } from 'harmonyos-api-runtime';
import { CreateInspectionReportNameRequest } from '../models/CreateInspectionReportNameRequest';
import { InspectionReportName } from '../models/InspectionReportName';
import { InspectionStandardRole } from '../models/InspectionStandardRole';
import { ObjectReportNameLink } from '../models/ObjectReportNameLink';
import { ReportNameParameterLink } from '../models/ReportNameParameterLink';
import { ReportNameStandardLink } from '../models/ReportNameStandardLink';
import { ReportNamesListObjectReportNameLinksResponse } from '../models/ReportNamesListObjectReportNameLinksResponse';
import { ReportNamesListReportNameParameterLinksResponse } from '../models/ReportNamesListReportNameParameterLinksResponse';
import { ReportNamesListReportNameStandardLinksResponse } from '../models/ReportNamesListReportNameStandardLinksResponse';
import { ReportNamesListReportNamesResponse } from '../models/ReportNamesListReportNamesResponse';
import { ReportNamesUnlinkObjectReportNameRequest } from '../models/ReportNamesUnlinkObjectReportNameRequest';
import { ReportNamesUnlinkReportNameParameterRequest } from '../models/ReportNamesUnlinkReportNameParameterRequest';
import { ReportNamesUnlinkReportNameStandardRequest } from '../models/ReportNamesUnlinkReportNameStandardRequest';
import { UpdateInspectionReportNameRequest } from '../models/UpdateInspectionReportNameRequest';

export class ReportNamesApi {
  private client: ApiClient;

  constructor(client: ApiClient) {
    this.client = client;
  }

  createReportName(req: CreateInspectionReportNameRequest): Promise<InspectionReportName> {
    let options: RequestOptions = { method: 'POST', path: `/api/report-names`, body: req };
    return this.client.request<InspectionReportName>(options);
  }

  deleteReportName(code: string): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/report-names/${code}` };
    return this.client.requestVoid(options);
  }

  getReportName(code: string): Promise<InspectionReportName> {
    let options: RequestOptions = { method: 'GET', path: `/api/report-names/${code}` };
    return this.client.request<InspectionReportName>(options);
  }

  linkObjectReportName(req: ObjectReportNameLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/report-names/links/object`, body: req };
    return this.client.requestVoid(options);
  }

  linkReportNameParameter(req: ReportNameParameterLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/report-names/links/parameter`, body: req };
    return this.client.requestVoid(options);
  }

  linkReportNameStandard(req: ReportNameStandardLink): Promise<void> {
    let options: RequestOptions = { method: 'POST', path: `/api/report-names/links/standard`, body: req };
    return this.client.requestVoid(options);
  }

  listObjectReportNameLinks(inspectionObjectCode?: string, reportNameCode?: string): Promise<ReportNamesListObjectReportNameLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (inspectionObjectCode !== undefined) {
      query.set('inspectionObjectCode', String(inspectionObjectCode));
    }
    if (reportNameCode !== undefined) {
      query.set('reportNameCode', String(reportNameCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/report-names/links/object`, query: query };
    return this.client.request<ReportNamesListObjectReportNameLinksResponse>(options);
  }

  listReportNameParameterLinks(reportNameCode?: string, inspectionParameterCode?: string): Promise<ReportNamesListReportNameParameterLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (reportNameCode !== undefined) {
      query.set('reportNameCode', String(reportNameCode));
    }
    if (inspectionParameterCode !== undefined) {
      query.set('inspectionParameterCode', String(inspectionParameterCode));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/report-names/links/parameter`, query: query };
    return this.client.request<ReportNamesListReportNameParameterLinksResponse>(options);
  }

  listReportNameStandardLinks(reportNameCode?: string, role?: InspectionStandardRole): Promise<ReportNamesListReportNameStandardLinksResponse> {
    let query: Map<string, string> = new Map<string, string>();
    if (reportNameCode !== undefined) {
      query.set('reportNameCode', String(reportNameCode));
    }
    if (role !== undefined) {
      query.set('role', String(role));
    }
    let options: RequestOptions = { method: 'GET', path: `/api/report-names/links/standard`, query: query };
    return this.client.request<ReportNamesListReportNameStandardLinksResponse>(options);
  }

  listReportNames(page?: number, pageSize?: number, keyword?: string): Promise<ReportNamesListReportNamesResponse> {
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
    let options: RequestOptions = { method: 'GET', path: `/api/report-names`, query: query };
    return this.client.request<ReportNamesListReportNamesResponse>(options);
  }

  unlinkObjectReportName(req: ReportNamesUnlinkObjectReportNameRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/report-names/links/object`, body: req };
    return this.client.requestVoid(options);
  }

  unlinkReportNameParameter(req: ReportNamesUnlinkReportNameParameterRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/report-names/links/parameter`, body: req };
    return this.client.requestVoid(options);
  }

  unlinkReportNameStandard(req: ReportNamesUnlinkReportNameStandardRequest): Promise<void> {
    let options: RequestOptions = { method: 'DELETE', path: `/api/report-names/links/standard`, body: req };
    return this.client.requestVoid(options);
  }

  updateReportName(code: string, req: UpdateInspectionReportNameRequest): Promise<InspectionReportName> {
    let options: RequestOptions = { method: 'PUT', path: `/api/report-names/${code}`, body: req };
    return this.client.request<InspectionReportName>(options);
  }
}
