-- A* Planner database setup. Run this once in Supabase: SQL Editor → New query → paste → Run.
-- One row per person; each row can only be read or changed by the account that owns it.

create table if not exists public.planners (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  state      jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.planners enable row level security;

drop policy if exists "planners: read own"   on public.planners;
drop policy if exists "planners: insert own" on public.planners;
drop policy if exists "planners: update own" on public.planners;
drop policy if exists "planners: delete own" on public.planners;

create policy "planners: read own"   on public.planners for select using (auth.uid() = user_id);
create policy "planners: insert own" on public.planners for insert with check (auth.uid() = user_id);
create policy "planners: update own" on public.planners for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "planners: delete own" on public.planners for delete using (auth.uid() = user_id);

-- Signed-in users may use the table; anonymous visitors may not.
revoke all on public.planners from anon;
grant select, insert, update, delete on public.planners to authenticated;

-- Accounts are usable immediately: mark each new user as confirmed at creation,
-- so nobody has to click an emailed link before signing in.
create or replace function public.auto_confirm_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.email_confirmed_at is null then
    new.email_confirmed_at := now();
  end if;
  return new;
end;
$$;

drop trigger if exists auto_confirm_user_on_signup on auth.users;
create trigger auto_confirm_user_on_signup
  before insert on auth.users
  for each row execute function public.auto_confirm_user();
