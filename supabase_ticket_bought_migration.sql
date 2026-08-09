alter table public.schedule_items
add column if not exists ticket_bought boolean not null default false;

drop policy if exists "Shared schedule can update ticket status" on public.schedule_items;
create policy "Shared schedule can update ticket status"
on public.schedule_items
for update
to anon
using (trip_id = 'fringe-2026')
with check (trip_id = 'fringe-2026');
