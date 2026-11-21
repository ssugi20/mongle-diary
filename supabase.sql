-- Supabase SQL Editor에서 실행
create table if not exists public.diary_records (
  user_id uuid not null references auth.users(id) on delete cascade,
  day date not null,
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, day)
);
alter table public.diary_records enable row level security;
create policy "Users can read own diary" on public.diary_records for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users can insert own diary" on public.diary_records for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users can update own diary" on public.diary_records for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Users can delete own diary" on public.diary_records for delete to authenticated using ((select auth.uid()) = user_id);
create index if not exists diary_records_user_updated_idx on public.diary_records (user_id, updated_at desc);
