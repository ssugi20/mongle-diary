# 🌷 몽글 다이어리 — 파스텔 올인원 웹앱

모바일 대응 웹사이트. 월간 캘린더, 일기, 일정, 할 일, 습관, 독서·영화, 날짜별 가계부, JSON 백업·복원, Supabase 이메일 로그인 및 날짜별 클라우드 자동 저장을 지원합니다.

## 1. Supabase 설정 (무료 요금제로 시작 가능)
1. https://supabase.com 에서 가입 후 **New project** 생성.
2. **SQL Editor**에서 프로젝트의 `supabase.sql` 전체를 실행. 사용자별 접근을 제한하는 RLS 정책이 포함되어 있습니다.
3. **Project Settings → API** (또는 Connect 메뉴)에서 Project URL과 **publishable key / anon key**를 확인합니다. **service_role / secret key는 절대로 웹앱에 넣지 마세요.**
4. **Authentication → Providers → Email**에서 이메일 로그인을 켭니다. 이메일 인증을 켜 두는 것을 권장합니다.
5. 배포 후 **Authentication → URL Configuration**의 Site URL과 Redirect URLs에 실제 웹사이트 주소를 등록합니다.
6. 다른 기기에서 실시간 변경을 즉시 반영하려면 Supabase Dashboard의 **Database → Publications → supabase_realtime**에서 `diary_records`를 활성화합니다. 활성화하지 않아도 재로그인/새로고침으로 서버 기록을 불러옵니다.

## 2. 로컬 실행
Node.js 20 이상 권장.
```bash
npm install
cp .env.example .env
```
`.env` 파일을 열고 실제 값으로 교체:
```
VITE_SUPABASE_URL=https://실제프로젝트.supabase.co
VITE_SUPABASE_ANON_KEY=실제_공개용_키
```
```bash
npm run dev
```
표시되는 주소(일반적으로 http://localhost:5173)로 접속하세요.

## 3. 배포 (Vercel 예시)
1. 이 프로젝트를 본인 GitHub 저장소에 올립니다. **`.env`는 올리지 마세요.**
2. https://vercel.com 에서 GitHub 저장소를 Import 합니다.
3. Framework Preset: **Vite**, Build Command: `npm run build`, Output Directory: `dist`.
4. Environment Variables에 `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`를 설정하고 Deploy.
5. 발급받은 HTTPS 주소를 Supabase Authentication URL Configuration에 등록합니다.
6. 휴대폰과 PC에서 같은 이메일 계정으로 로그인하면 동일한 데이터를 볼 수 있습니다.

## 저장 방식과 주의사항
- 입력 후 약 0.65초 뒤 Supabase에 자동 저장하며 저장 상태를 화면에 표시합니다. 오프라인에서는 저장되지 않습니다.
- 날짜를 변경하거나 탭을 전환할 때 미저장 기록을 먼저 서버에 저장합니다.
- 다른 기기의 변경을 실시간으로 받으려면 Realtime 설정이 필요합니다. **동일 날짜를 두 기기에서 동시에 수정하면 마지막 저장이 앞선 기록을 덮어쓸 수 있습니다.**
- 로그인 정보는 Supabase Auth에서 관리하며, 사용자별 행 접근은 RLS로 제한합니다.
- 백업은 JSON 다운로드/불러오기. 개인정보가 포함될 수 있으므로 안전한 곳에 보관하세요.
- 독서와 영화는 **날짜당 각 1개 작품**, 가계부 합계는 **선택 날짜 기준**입니다.
- Supabase/Vercel의 무료 요금제 제한 및 가격은 변경될 수 있습니다.
- 이 ZIP 파일 자체는 배포된 웹사이트가 아닙니다. 배포를 마쳐야 인터넷 주소로 사용할 수 있습니다.
