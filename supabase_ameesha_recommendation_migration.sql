alter table public.schedule_items
add column if not exists ameesha_recommendation boolean not null default false;
