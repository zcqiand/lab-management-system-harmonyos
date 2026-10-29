// 入口 Ability：只挂 Index 页（首页切片，lab 首业务消费）。下方 [shared 触碰] 仅保留
// 尚未接页面的 Api 类——ArkTS 编译图 = import 闭包，未 import 的生成文件不进编译；
// 各片接线后从触碰集移除（AuthApi/CatalogApi 已由 session/Session.ets + pages/Index.ets 消费）。
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { CalculationMethodsApi, ContractsApi, FrontendBindMetaApi, InspectionDictionaryApi, ParamInterfacesApi, ReceiptsApi, ReportNamesApi, SamplesApi, SummaryApi, TechnicalRequirementsApi, TestRecordsApi } from '../shared';
import { ApiClient } from 'harmonyos-api-runtime';

// [shared 触碰] 未接线 Api 类实例化触碰：编译覆盖占位（spike 同款），逐片消费后移除。
const __SHARED_TOUCH__: Array<Object> = [
  new CalculationMethodsApi(new ApiClient('https://touch.invalid')),
  new ContractsApi(new ApiClient('https://touch.invalid')),
  new FrontendBindMetaApi(new ApiClient('https://touch.invalid')),
  new InspectionDictionaryApi(new ApiClient('https://touch.invalid')),
  new ParamInterfacesApi(new ApiClient('https://touch.invalid')),
  new ReceiptsApi(new ApiClient('https://touch.invalid')),
  new ReportNamesApi(new ApiClient('https://touch.invalid')),
  new SamplesApi(new ApiClient('https://touch.invalid')),
  new SummaryApi(new ApiClient('https://touch.invalid')),
  new TechnicalRequirementsApi(new ApiClient('https://touch.invalid')),
  new TestRecordsApi(new ApiClient('https://touch.invalid')),
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
