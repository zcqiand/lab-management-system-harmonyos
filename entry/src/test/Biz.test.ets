// 业务测试（首个带业务 ID 锚的测试面，人批 2026-10-31）：合同 CRUD 写流
// （M02.F01.I03 创建 / I04 更新 / I05 删除）。只 import 纯表单装配模块 + 生成模型
// （不触 runtime/@ohos），本地单测无设备依赖。live 端到端由 _work/ 探针承担。
import { describe, it, expect } from '@ohos/hypium';
import {
  ContractForm, assembleCreateContract, assembleUpdateContract, ensureContractId
} from '../main/ets/forms/ContractForms';

function fullForm(): ContractForm {
  let f: ContractForm = {
    contractCode: 'HT-2026-001',
    clientUnit: '委托单位甲',
    projectName: '某大厦检测',
    constructionUnit: '施工单位乙',
    witnessUnit: '见证单位丙',
    witness: '见证人丁',
    projectLocation: '',
    status: ''
  };
  return f;
}

export function contractCreateSuite(): void {
  describe('contract_create_form', () => {
    // fn: M02.F01.I03
    it('create contract assembles required fields and defaults status active', 0, () => {
      let req = assembleCreateContract(fullForm());
      expect(req.contractCode).assertEqual('HT-2026-001');
      expect(req.clientUnit).assertEqual('委托单位甲');
      expect(req.projectName).assertEqual('某大厦检测');
      expect(req.constructionUnit).assertEqual('施工单位乙');
      expect(req.witnessUnit).assertEqual('见证单位丙');
      expect(req.witness).assertEqual('见证人丁');
      expect(req.status).assertEqual('active');
    });
    // fn: M02.F01.I03
    it('create contract throws when any required field is blank（fail-fast 禁空串入请求）', 0, () => {
      let fields: string[] = ['contractCode', 'clientUnit', 'projectName',
        'constructionUnit', 'witnessUnit', 'witness'];
      for (let i = 0; i < fields.length; i++) {
        let f = fullForm();
        blankField(f, fields[i]);
        let threw = false;
        try {
          assembleCreateContract(f);
        } catch {
          threw = true;
        }
        expect(threw).assertTrue();
      }
    });
    // fn: M02.F01.I03
    it('create contract trims whitespace on required fields', 0, () => {
      let f = fullForm();
      f.contractCode = '  HT-2026-002  ';
      let req = assembleCreateContract(f);
      expect(req.contractCode).assertEqual('HT-2026-002');
    });
    // fn: M02.F01.I03
    it('create contract includes projectLocation only when filled', 0, () => {
      let f = fullForm();
      let reqWithout = assembleCreateContract(f);
      expect(reqWithout.projectLocation).assertUndefined();
      f.projectLocation = '某市某区';
      let reqWith = assembleCreateContract(f);
      expect(reqWith.projectLocation).assertEqual('某市某区');
    });
  });
}

export function contractUpdateSuite(): void {
  describe('contract_update_form', () => {
    // fn: M02.F01.I04
    it('update contract includes only filled fields（PUT PATCH 语义）', 0, () => {
      let e: ContractForm = {
        contractCode: '', clientUnit: '', projectName: '', constructionUnit: '',
        witnessUnit: '', witness: '', projectLocation: '', status: ''
      };
      e.projectName = '改名后的工程';
      let req = assembleUpdateContract(e);
      expect(req.projectName).assertEqual('改名后的工程');
      expect(req.contractCode).assertUndefined();
      expect(req.clientUnit).assertUndefined();
    });
    // fn: M02.F01.I04
    it('update contract with all fields empty yields empty body（不动任何字段）', 0, () => {
      let f = fullForm();
      let e: ContractForm = {
        contractCode: '', clientUnit: '', projectName: '', constructionUnit: '',
        witnessUnit: '', witness: '', projectLocation: '', status: ''
      };
      let req = assembleUpdateContract(e);
      expect(Object.keys(req).length).assertEqual(0);
    });
    // fn: M02.F01.I04
    it('update contract carries status only when filled', 0, () => {
      let f = fullForm();
      let reqWithout = assembleUpdateContract(f);
      expect(reqWithout.status).assertUndefined();
      f.status = 'archived';
      let reqWith = assembleUpdateContract(f);
      expect(reqWith.status).assertEqual('archived');
    });
  });
}

export function contractDeleteSuite(): void {
  describe('contract_delete_guard', () => {
    // fn: M02.F01.I05
    it('delete contract accepts non-empty id trimmed', 0, () => {
      expect(ensureContractId('  c-1  ')).assertEqual('c-1');
    });
    // fn: M02.F01.I05
    it('delete contract throws on blank id（fail-fast）', 0, () => {
      let threwBlank = false;
      let threwWs = false;
      try {
        ensureContractId('');
      } catch {
        threwBlank = true;
      }
      try {
        ensureContractId('   ');
      } catch {
        threwWs = true;
      }
      expect(threwBlank).assertTrue();
      expect(threwWs).assertTrue();
    });
  });
}

// 按字段名置空（测试专用反射替身：ArkTS 无 dynamic pick，逐字段 if 链）
function blankField(f: ContractForm, field: string): void {
  if (field === 'contractCode') {
    f.contractCode = '';
  } else if (field === 'clientUnit') {
    f.clientUnit = '';
  } else if (field === 'projectName') {
    f.projectName = '';
  } else if (field === 'constructionUnit') {
    f.constructionUnit = '';
  } else if (field === 'witnessUnit') {
    f.witnessUnit = '';
  } else if (field === 'witness') {
    f.witness = '';
  }
}
