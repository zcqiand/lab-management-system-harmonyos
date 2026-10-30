// 入口 Ability：只挂 Index 页（首页 + 码表 + 检测能力 + 业务数据 + 汇总 五只读片）。
// [shared 触碰] 12 个生成 Api 类中 11 个已由 Session 装配消费（ArkTS 编译图 =
// import 闭包：AuthApi/CatalogApi 首页片，码表片三类，InspectionDictionaryApi/
// ParamInterfacesApi 检测能力片，ContractsApi/ReceiptsApi/SamplesApi/TestRecordsApi
// 业务数据片，SummaryApi 汇总片）。
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { FrontendBindMetaApi } from '../shared';
import { ApiClient } from 'harmonyos-api-runtime';

// [shared 触碰] FrontendBindMetaApi 永久编译覆盖占位：frontend-bind.tsp 全表面
// @deprecated（ADR-0014）——runtime 实现已删（springboot 404 实证 2026-10-30），
// react/vue 消费者 0 import，生成物留库仅供 codegen 完整性；此占位非「待接线」，
// 不要在后续切片中移除。
const __SHARED_TOUCH__: Array<Object> = [
  new FrontendBindMetaApi(new ApiClient('https://touch.invalid')),
];
void __SHARED_TOUCH__;

const DOMAIN: number = 0x0000;
const TAG: string = 'EntryAbility';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, TAG, 'loadContent failed: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, TAG, '%{public}s', 'loadContent ok');
    });
  }

  onWindowStageDestroy(): void {
  }

  onForeground(): void {
  }

  onBackground(): void {
  }
}
