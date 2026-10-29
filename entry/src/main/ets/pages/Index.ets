// 首页（lab 首业务消费切片）：AuthApi.login（后端代理 saas IdP，无 clientId 面）→
// SessionState → CatalogApi.listBrands 只读列表。base URL 走 rawfile config.json
// （AppConfig fail-fast，禁默认值兜底）；错误显示 ApiError 的 code+message。
import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { ApiError } from 'harmonyos-api-runtime';
import { CatalogListBrandsResponse } from '../shared/models/CatalogListBrandsResponse';
import { InspectionBrand } from '../shared/models/InspectionBrand';
import { session } from '../session/Session';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State message: string = '实验室管理系统（HarmonyOS ArkTS 版）';
  @State busy: boolean = false;
  @State loggedIn: boolean = false;
  @State brands: CatalogListBrandsResponse | null = null;

  private async ensureConfigured(): Promise<void> {
    if (this.loggedIn) {
      return;
    }
    const ctx = getContext(this) as common.UIAbilityContext;
    const raw = await ctx.resourceManager.getRawFileContent('config.json');
    const text = util.TextDecoder.create('utf-8').decodeToString(raw);
    session.configure(text);
    if (session.authenticated()) {
      this.loggedIn = true;
    }
  }

  private async loadBrands(): Promise<void> {
    this.brands = await session.listBrands(1, 20);
  }

  private async doLogin(): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    this.message = '';
    try {
      await this.ensureConfigured();
      await session.login(this.username, this.password);
      await this.loadBrands();
      this.loggedIn = true;
    } catch (err) {
      const apiErr = err as ApiError;
      if (apiErr.code !== undefined && apiErr.code !== '') {
        this.message = `登录失败：${apiErr.code} ${apiErr.message}`;
      } else {
        this.message = `登录失败：${(err as Error).message}`;
      }
    } finally {
      this.busy = false;
    }
  }

  private async doLogout(): Promise<void> {
    if (this.busy) {
      return;
    }
    this.busy = true;
    try {
      await session.logout();
    } catch (err) {
      this.message = `登出异常：${(err as Error).message}`;
    } finally {
      this.loggedIn = false;
      this.brands = null;
      this.password = '';
      this.busy = false;
    }
  }

  build() {
    Column({ space: 12 }) {
      Text('实验室管理系统')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
      Text('HarmonyOS ArkTS（X14 槽）')
        .fontSize(13)
        .opacity(0.6)

      if (!this.loggedIn) {
        TextInput({ placeholder: '用户名', text: this.username })
          .width('80%')
          .onChange((v: string) => {
            this.username = v;
          })
        TextInput({ placeholder: '密码', text: this.password })
          .type(InputType.Password)
          .width('80%')
          .onChange((v: string) => {
            this.password = v;
          })
        Button(this.busy ? '登录中…' : '登录')
          .width('80%')
          .enabled(!this.busy)
          .onClick(() => {
            this.doLogin();
          })
      } else {
        Text(`检验品牌（共 ${this.brands !== null ? this.brands.total : 0} 条）`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        if (this.brands !== null && this.brands.items.length > 0) {
          List() {
            ForEach(this.brands.items, (item: InspectionBrand) => {
              ListItem() {
                Column({ space: 2 }) {
                  Text(`${item.code} · ${item.name}`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text(item.remark !== undefined ? item.remark : '—')
                    .fontSize(12)
                    .opacity(0.6)
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')
              }
              .padding(6)
            }, (item: InspectionBrand) => item.code)
          }
          .width('88%')
          .height('45%')
        } else {
          Text('（无品牌数据）')
            .fontSize(13)
            .opacity(0.6)
        }
        Button(this.busy ? '登出中…' : '登出')
          .width('80%')
          .enabled(!this.busy)
          .onClick(() => {
            this.doLogout();
          })
      }

      if (this.message !== '') {
        Text(this.message)
          .fontSize(13)
          .opacity(0.75)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
