-- Run this once in Supabase: SQL Editor > New query > paste > Run.
-- It is safe to run again. It skips things that already exist.

create table if not exists public.registrations (
  id          bigint generated always as identity primary key,
  full_name   text not null,
  size        text not null,
  created_at  timestamptz not null default now()
);

-- Lock the table. Without a policy, nobody can read or write from the website.
alter table public.registrations enable row level security;

-- Visitors may ONLY add rows. They can never read, change or delete anything.
grant insert on public.registrations to anon;

drop policy if exists "anyone can register" on public.registrations;
create policy "anyone can register"
  on public.registrations
  for insert
  to anon
  with check (
    char_length(btrim(full_name)) between 3 and 80
    and size in ('S', 'M', 'L', 'XL', 'XXL')
  );

-- One registration per name (Abebe Kebede and abebe kebede count as the same).
create unique index if not exists one_per_name
  on public.registrations (lower(btrim(full_name)));
