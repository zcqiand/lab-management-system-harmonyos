// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { ContractStatus } from './ContractStatus';

export interface UpdateContractRequest {
  contractCode?: string;
  clientUnit?: string;
  projectName?: string;
  projectLocation?: string;
  constructionUnit?: string;
  inspectionSpecialtyCode?: string;
  buildingUnit?: string;
  supervisorUnit?: string;
  inspectionPerson?: string;
  inspectionPhone?: string;
  witnessUnit?: string;
  witness?: string;
  witnessPhone?: string;
  contactPerson?: string;
  contactPhone?: string;
  entrustedDate?: string;
  status?: ContractStatus;
}
