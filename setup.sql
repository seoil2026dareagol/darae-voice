-- Supabase 대시보드 > SQL Editor 에 통째로 붙여넣고 Run 하세요.
-- 관객(anon)은 "보내기"만 가능하고 읽을 수 없습니다. 읽기/삭제는 로그인한 스태프만 가능합니다.

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  actor int not null check (actor between 1 and 18),
  body text check (body is null or char_length(body) <= 500),
  audio_path text,
  created_at timestamptz not null default now()
);

alter table public.messages enable row level security;

create policy "관객은 보내기만" on public.messages
  for insert to anon with check (true);
create policy "스태프만 읽기" on public.messages
  for select to authenticated using (true);
create policy "스태프만 삭제" on public.messages
  for delete to authenticated using (true);

-- 음성 파일 저장소: 비공개, 파일당 3MB 제한
insert into storage.buckets (id, name, public, file_size_limit)
values ('voices', 'voices', false, 3145728)
on conflict (id) do update set public = false, file_size_limit = 3145728;

create policy "관객은 업로드만" on storage.objects
  for insert to anon with check (bucket_id = 'voices');
create policy "스태프만 음성 읽기" on storage.objects
  for select to authenticated using (bucket_id = 'voices');
create policy "스태프만 음성 삭제" on storage.objects
  for delete to authenticated using (bucket_id = 'voices');
