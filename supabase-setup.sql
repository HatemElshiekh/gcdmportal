-- Supabase setup for the shared editable dashboard.
-- Run this once in Supabase Dashboard > SQL Editor.

create table if not exists public.dashboard_pages (
  id text primary key,
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.dashboard_pages replica identity full;
alter table public.dashboard_pages enable row level security;

drop policy if exists "dashboard_pages_public_select" on public.dashboard_pages;
drop policy if exists "dashboard_pages_public_insert" on public.dashboard_pages;
drop policy if exists "dashboard_pages_public_update" on public.dashboard_pages;
drop policy if exists "dashboard_pages_public_delete" on public.dashboard_pages;

-- No password / no login version: anyone who can load the site and has the public key can read and edit these two dashboard records.
create policy "dashboard_pages_public_select"
  on public.dashboard_pages for select
  to anon
  using (true);

create policy "dashboard_pages_public_insert"
  on public.dashboard_pages for insert
  to anon
  with check (id in ('phase-1', 'phase-2'));

create policy "dashboard_pages_public_update"
  on public.dashboard_pages for update
  to anon
  using (id in ('phase-1', 'phase-2'))
  with check (id in ('phase-1', 'phase-2'));

create policy "dashboard_pages_public_delete"
  on public.dashboard_pages for delete
  to anon
  using (id in ('phase-1', 'phase-2'));

grant select, insert, update, delete on public.dashboard_pages to anon;

-- Enable realtime updates for this table.
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'dashboard_pages'
  ) then
    alter publication supabase_realtime add table public.dashboard_pages;
  end if;
end $$;

-- Optional seed records. The dashboards will also create these automatically on first load.
insert into public.dashboard_pages (id, content)
values
  ('phase-1', '{}'::jsonb),
  ('phase-2', '{}'::jsonb)
on conflict (id) do nothing;
