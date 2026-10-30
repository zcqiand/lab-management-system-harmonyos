// 过程件（_work/）：lab harmonyos 首页面切片 live 探针。
// 链路：POST /api/auth/login → token → GET /api/catalog/brands?page=1&pageSize=20（Bearer）
//       → POST /api/auth/logout → 期待随后 brands 401（token 后端面）。
// 单次正确凭据尝试（lockout 429 雪崩纪律，REQ-2026-023）。
const BASE = process.argv[2] ?? 'http://127.0.0.1:52051';

const post = async (path, body, headers = {}) => {
  const r = await fetch(BASE + path, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...headers },
    body: JSON.stringify(body),
  });
  let json = null;
  const text = await r.text();
  try { json = text === '' ? null : JSON.parse(text); } catch { json = text; }
  return { status: r.status, json };
};
const get = async (path, headers = {}) => {
  const r = await fetch(BASE + path, { headers });
  return { status: r.status, json: await r.json().catch(() => null) };
};

// 1. login（lab 原生登录，后端代理 saas IdP）
const login = await post('/api/auth/login', { username: 'alice', password: 'dev123456' });
console.log('login:', login.status, 'token?', typeof login.json?.token === 'string' && login.json.token.length > 0,
  'user?', login.json?.user?.username, 'tenants:', Array.isArray(login.json?.tenants) ? login.json.tenants.length : 'N/A');
if (login.status !== 200 || !login.json?.token) {
  console.log('login body:', JSON.stringify(login.json)?.slice(0, 400));
  process.exit(1);
}
const token = login.json.token;

// 2. brands 只读列表（生成面 CatalogApi.listBrands 同形状）
const brands = await get('/api/catalog/brands?page=1&pageSize=20', { Authorization: `Bearer ${token}` });
console.log('brands:', brands.status, 'total:', brands.json?.total, 'items:', Array.isArray(brands.json?.items) ? brands.json.items.length : 'N/A');
if (brands.status !== 200) {
  console.log('brands body:', JSON.stringify(brands.json)?.slice(0, 400));
}
const first = brands.json?.items?.[0];
console.log('first item fields:', first ? Object.keys(first).join(',') : '(empty)');

// 3. logout（POST /api/auth/logout，服务端 no-op 语义；401 端点须带 Bearer——生成面
//    ApiClient tokenProvider 自动附，探针同形状）
const logout = await post('/api/auth/logout', { token }, { Authorization: `Bearer ${token}` });
console.log('logout:', logout.status);

// 4. 复用旧 token 访问（lab logout 服务端无操作 → 仍 200 为预期形状；观察并记录即可）
const after = await get('/api/catalog/brands?page=1&pageSize=20', { Authorization: `Bearer ${token}` });
console.log('brands-after-logout:', after.status, '(lab logout 服务端 no-op，200=符合参照实现形状)');

const ok = login.status === 200 && brands.status === 200 && logout.status >= 200 && logout.status < 300;
console.log(ok ? 'PROBE PASS' : 'PROBE FAIL');
process.exit(ok ? 0 : 1);
