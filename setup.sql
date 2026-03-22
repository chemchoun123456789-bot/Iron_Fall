-- ══════════════════════════════════════
-- IRON FALL — Supabase Database Setup
-- Run this in: Supabase → SQL Editor
-- ══════════════════════════════════════

-- 1. LEADERBOARD TABLE
create table if not exists leaderboard (
  id uuid default gen_random_uuid() primary key,
  email text not null,
  display_name text not null,
  best_wave integer default 0,
  kills integer default 0,
  season text not null,
  gender text default 'male',
  equipped_skin text default 'm_common_0',
  title text default 'recruit',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(email, season)
);

-- 2. Enable Row Level Security
alter table leaderboard enable row level security;

-- 3. Allow anyone to READ leaderboard (public)
create policy "Public read leaderboard"
  on leaderboard for select
  using (true);

-- 4. Allow anyone to INSERT their own entry
create policy "Insert own entry"
  on leaderboard for insert
  with check (true);

-- 5. Allow anyone to UPDATE their own entry
create policy "Update own entry"
  on leaderboard for update
  using (true);

-- 6. Index for fast sorting
create index if not exists lb_season_wave_idx
  on leaderboard (season, best_wave desc, kills desc);

-- ══════════════════════════════════════
-- Done! Click "Run" then come back 🚀
-- ══════════════════════════════════════
