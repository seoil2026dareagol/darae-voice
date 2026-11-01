# 배우에게 한마디 - 〈우리 다래골은〉

관객이 QR을 찍으면 해당 배우 전용 페이지가 열리고, 글이나 목소리(최대 30초)를 보낼 수 있습니다.
- 관객은 보내기만 가능합니다. 다른 관객의 메시지는 읽을 수도 들을 수도 없습니다.
- 스태프만 `staff.html`에서 로그인해 듣고, 부적절한 것은 삭제하고, 마지막 공연 날 배우별 ZIP(글+음성)을 내려받아 전달합니다.
- 비용 0원: Supabase 무료 플랜 + GitHub Pages.

## 파일
| 파일 | 역할 |
|---|---|
| `index.html` | 관객용. `?a=번호`로 배우 지정 |
| `staff.html` | 스태프용 (로그인 필요) |
| `qr.html` | 배우 18명 QR 인쇄용 |
| `config.js` | 주소, 키, 배우 명단 설정 |
| `setup.sql` | 데이터베이스 설정 (한 번만 실행) |

## 설치 순서 (약 30분)

### 1. Supabase 프로젝트 만들기
1. supabase.com 가입 후 New project (지역은 Northeast Asia (Seoul) 권장).
2. 왼쪽 **SQL Editor** → `setup.sql` 내용을 통째로 붙여넣고 **Run**.
3. 왼쪽 **Authentication → Users → Add user → Create new user**: 스태프용 이메일/비밀번호 생성 (Auto Confirm 체크).
4. **중요: Authentication → Sign In / Providers**(또는 Settings)에서 **Allow new users to sign up 을 끄세요.** 켜져 있으면 누구나 가입해서 모든 메시지를 읽을 수 있습니다.
5. **Project Settings → API**에서 `Project URL`과 `anon public` 키를 복사.

### 2. config.js 수정
`SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SITE_URL` 세 값을 채웁니다. (`service_role` 키는 절대 넣지 마세요.)

### 3. GitHub Pages로 올리기
1. GitHub에서 새 저장소(예: `darae-voice`)를 만들고 이 폴더의 파일을 모두 올립니다.
2. Settings → Pages → Branch: main / root 선택 → 저장.
3. 몇 분 뒤 `https://내계정.github.io/darae-voice/` 로 열립니다. 이 주소를 `config.js`의 `SITE_URL`에 적습니다.

### 4. QR 만들기
`SITE_URL/qr.html`을 열어 18장을 인쇄하고 캐스팅보드에 붙입니다.

## 공연 전 필수 테스트
- 아이폰(사파리)과 안드로이드(크롬)에서 각각 QR → 녹음 → 보내기. 마이크 허용 창이 뜹니다.
- 카카오톡 카메라로 찍었을 때 녹음이 안 되면 글만 가능합니다. 현장에 **"휴대폰 기본 카메라로 찍어주세요"** 안내를 붙이세요.
- `staff.html`에서 로그인해 방금 보낸 메시지가 보이는지, 음성이 재생되는지, ZIP이 받아지는지 확인.
- 확인용 메시지는 스태프 화면에서 삭제.
- 지하 공연장이면 와이파이 안내가 있으면 좋습니다.

## 운영 팁
- 스태프 로그인 정보는 최소한의 사람만 공유하세요.
- 마지막 공연 날: staff.html → 배우별 "묶음 내려받기" → 폴더(또는 USB, 클라우드)로 전달.
- 공연이 끝나면 약속한 대로 Supabase의 `messages` 표와 `voices` 저장소를 비우고 프로젝트를 삭제하세요.
- 안내문 문구: "녹음은 해당 배우에게만 전달되며, 공연 홍보에 사용될 수 있습니다. 공연 종료 후 삭제됩니다." (페이지에 이미 들어 있으니, 홍보에 쓰지 않을 계획이라면 `index.html`에서 해당 문구를 빼세요.)
- Supabase 무료 플랜은 1주일 이상 활동이 없으면 일시정지될 수 있습니다. 공연 직전에 한 번 접속해 확인하세요.
