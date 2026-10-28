// 本文件由 harmonyos-api-gen 生成，禁手改；regen 先删后写（幂等字节级，无时间戳）。

import { AuthStateAnonymous } from './AuthStateAnonymous';
import { AuthStateAuthenticated } from './AuthStateAuthenticated';
import { AuthStateAwaiting_tenant } from './AuthStateAwaiting_tenant';
import { AuthStateIdle } from './AuthStateIdle';

export type AuthState = AuthStateIdle | AuthStateAnonymous | AuthStateAwaiting_tenant | AuthStateAuthenticated;
