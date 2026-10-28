// 入口 Ability：只挂 Index 页。下方 [shared 触碰] 是生成物编译图闭包点——ArkTS 编译图 =
// import 闭包，未 import 的生成文件不进编译（spike 阴性对照实证）；Phase 1 页面接线后由真实消费替换。
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AuthApi, CalculationMethodsApi, CatalogApi, ContractsApi, FrontendBindMetaApi, InspectionDictionaryApi, ParamInterfacesApi, ReceiptsApi, ReportNamesApi, SamplesApi, SummaryApi, TechnicalRequirementsApi, TestRecordsApi } from '../shared';
import { ApiClient } from 'harmonyos-api-runtime';

// [shared 触碰] 全部 13 个 Api 类实例化触碰：生成区全量编译覆盖（spike 同款）。
const __SHARED_TOUCH__: Array<Object> = [
  new AuthApi(new ApiClient('https://touch.invalid')),
  new CalculationMethodsApi(new ApiClient('https://touch.invalid')),
  new CatalogApi(new ApiClient('https://touch.invalid')),
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
