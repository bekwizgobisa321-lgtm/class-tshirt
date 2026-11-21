-- Run this once in Supabase: SQL Editor > New query > paste > Run.
-- It is safe to run again. It does not touch your other tables.

-- 1) Table for the "left money" payments
create table if not exists public.cs_balance_payments (
  id               bigint generated always as identity primary key,
  full_name        text not null,
  screenshot_path  text not null,
  status           text not null default 'pending',  -- you change it to 'paid' after you check
  created_at       timestamptz not null default now()
);

alter table public.cs_balance_payments enable row level security;

-- Visitors may ONLY add rows. They can never read, change or delete anything.
grant insert on public.cs_balance_payments to anon;

drop policy if exists "anyone can send balance payment" on public.cs_balance_payments;
create policy "anyone can send balance payment"
  on public.cs_balance_payments
  for insert
  to anon
  with check (
    char_length(btrim(full_name)) between 3 and 80
    and status = 'pending'
    and screenshot_path ~ '^[a-z0-9-]{3,120}\.(jpg|jpeg|png|webp)$'
  );

-- 2) Private storage bucket for the screenshots (max 5 MB, images only)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'balance-screenshots',
  'balance-screenshots',
  false,
  5242880,
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do nothing;

-- Visitors may ONLY upload into this bucket. They cannot list, read or delete files.
drop policy if exists "anyone can upload balance screenshot" on storage.objects;
create policy "anyone can upload balance screenshot"
  on storage.objects
  for insert
  to anon
  with check (bucket_id = 'balance-screenshots');
