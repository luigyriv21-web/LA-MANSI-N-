-- LA MANSIÓN 10.10.1 — complementos para el servidor Supabase Auth
-- Ejecutar una sola vez en Supabase > SQL Editor.

alter table public.stories add column if not exists tags jsonb not null default '[]'::jsonb;

create table if not exists public.chapters (
  id uuid primary key default gen_random_uuid(),
  story_id uuid not null references public.stories(id) on delete cascade,
  title text not null default 'Capítulo',
  body text not null default '',
  position integer not null default 1,
  published boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists chapters_story_idx on public.chapters(story_id, position);
alter table public.chapters enable row level security;
drop policy if exists chapters_select on public.chapters;
create policy chapters_select on public.chapters for select using (published = true or exists (select 1 from public.stories s where s.id = story_id and s.author_id = auth.uid()));
drop policy if exists chapters_insert on public.chapters;
create policy chapters_insert on public.chapters for insert with check (exists (select 1 from public.stories s where s.id = story_id and s.author_id = auth.uid()));
drop policy if exists chapters_update on public.chapters;
create policy chapters_update on public.chapters for update using (exists (select 1 from public.stories s where s.id = story_id and s.author_id = auth.uid())) with check (exists (select 1 from public.stories s where s.id = story_id and s.author_id = auth.uid()));

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  type text not null,
  text text not null,
  meta jsonb not null default '{}'::jsonb,
  read boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists notifications_user_idx on public.notifications(user_id, created_at desc);
alter table public.notifications enable row level security;
drop policy if exists notifications_select on public.notifications;
create policy notifications_select on public.notifications for select using (auth.uid() = user_id);
drop policy if exists notifications_update on public.notifications;
create policy notifications_update on public.notifications for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Las notificaciones se crean mediante triggers SECURITY DEFINER, no desde el cliente.
create or replace function public.notify_new_follow()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.notifications(user_id,type,text,meta)
  select new.following_id,'follow',coalesce(p.name,'Un habitante') || ' ha tocado tu puerta.',jsonb_build_object('userId',new.follower_id)
  from public.profiles p where p.id = new.follower_id;
  return new;
end; $$;

drop trigger if exists trg_notify_follow on public.follows;
create trigger trg_notify_follow after insert on public.follows for each row execute procedure public.notify_new_follow();

create or replace function public.notify_new_message()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.notifications(user_id,type,text,meta)
  select new.recipient_id,'message',coalesce(p.name,'Un habitante') || ' te ha dejado una carta.',jsonb_build_object('messageId',new.id)
  from public.profiles p where p.id = new.sender_id;
  return new;
end; $$;

drop trigger if exists trg_notify_message on public.messages;
create trigger trg_notify_message after insert on public.messages for each row execute procedure public.notify_new_message();
