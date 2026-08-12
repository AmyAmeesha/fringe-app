alter table public.events
add column if not exists venue_address text,
add column if not exists venue_postcode text,
add column if not exists venue_lat numeric(10,7),
add column if not exists venue_lng numeric(10,7);

-- Example verified from the public listing:
-- https://www.edfringe.com/tickets/whats-on/call-her-the-ringmaster
-- Venue: Braw Venues @ Hill Street, address 19 Hill St, EH2 3JP.
update public.events
set
  venue_address = '19 Hill St',
  venue_postcode = 'EH2 3JP'
where lower(title) = 'call her the ringmaster';

create index if not exists events_venue_postcode_idx on public.events(venue_postcode);
