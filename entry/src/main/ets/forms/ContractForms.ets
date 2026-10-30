// 合同写流纯表单装配（M02.F01.I03/I04/I05，2026-10-31 人批业务 ID 锚）。
// 只做字符串进 → 请求模型出的纯变换（trim + 必填 fail-fast + PATCH 语义选字段），
// 不触 runtime/@ohos——Session 持有它，本地单测直测本文件。
import { CreateContractRequest } from '../shared/models/CreateContractRequest';
import { UpdateContractRequest } from '../shared/models/UpdateContractRequest';
import { ContractStatus } from '../shared/models/ContractStatus';

// 表单面 = UI TextInput 原文（全 string）；'' 表示未填。
// status 仅更新流消费（'' = 不动该字段）；创建流缺省 active（契约默认）。
export interface ContractForm {
  contractCode: string;
  clientUnit: string;
  projectName: string;
  constructionUnit: string;
  witnessUnit: string;
  witness: string;
  projectLocation: string;
  status: string;
}

function required(value: string, label: string): string {
  const t = value.trim();
  if (t.length === 0) {
    throw new Error(`合同 ${label} 必填（fail-fast，禁空串入请求）`);
  }
  return t;
}

function optional(value: string): string {
  return value.trim();
}

// 合法状态校验：非法值抛（禁静默丢字段兜底）
function asStatus(value: string): ContractStatus {
  if (value === 'active' || value === 'archived') {
    return value;
  }
  throw new Error(`合同状态非法：${value}（仅 active/archived）`);
}

export function assembleCreateContract(form: ContractForm): CreateContractRequest {
  const req: CreateContractRequest = {
    contractCode: required(form.contractCode, '合同编号'),
    clientUnit: required(form.clientUnit, '委托单位'),
    projectName: required(form.projectName, '工程名称'),
    constructionUnit: required(form.constructionUnit, '施工单位'),
    witnessUnit: required(form.witnessUnit, '见证单位'),
    witness: required(form.witness, '见证人'),
    status: 'active'
  };
  const loc = optional(form.projectLocation);
  if (loc.length > 0) {
    req.projectLocation = loc;
  }
  const st = optional(form.status);
  if (st.length > 0) {
    req.status = asStatus(st);
  }
  return req;
}

// PUT PATCH 语义（树 M02.F01.I04）：只带显式填写字段，'' = 不动
export function assembleUpdateContract(form: ContractForm): UpdateContractRequest {
  const req: UpdateContractRequest = {};
  const code = optional(form.contractCode);
  if (code.length > 0) {
    req.contractCode = code;
  }
  const clientUnit = optional(form.clientUnit);
  if (clientUnit.length > 0) {
    req.clientUnit = clientUnit;
  }
  const projectName = optional(form.projectName);
  if (projectName.length > 0) {
    req.projectName = projectName;
  }
  const constructionUnit = optional(form.constructionUnit);
  if (constructionUnit.length > 0) {
    req.constructionUnit = constructionUnit;
  }
  const witnessUnit = optional(form.witnessUnit);
  if (witnessUnit.length > 0) {
    req.witnessUnit = witnessUnit;
  }
  const witness = optional(form.witness);
  if (witness.length > 0) {
    req.witness = witness;
  }
  const loc = optional(form.projectLocation);
  if (loc.length > 0) {
    req.projectLocation = loc;
  }
  const st = optional(form.status);
  if (st.length > 0) {
    req.status = asStatus(st);
  }
  return req;
}

// 删除守卫：id trim 后非空（M02.F01.I05）
export function ensureContractId(id: string): string {
  const t = id.trim();
  if (t.length === 0) {
    throw new Error('合同 id 必填（fail-fast，禁空 id 入请求）');
  }
  return t;
}
