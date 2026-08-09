alter table public.events
add column if not exists ticket_url text;

-- Populate a best-effort EdFringe ticket link for every event.
-- Canonical corrections for high-signal trip-window shows should override
-- this generated value below as they are verified.
update public.events
set ticket_url = 'https://www.edfringe.com/tickets/whats-on/' ||
  regexp_replace(
    regexp_replace(
      regexp_replace(lower(title), '&', ' and ', 'g'),
      '[^a-z0-9]+',
      '-',
      'g'
    ),
    '(^-+|-+$)',
    '',
    'g'
  )
where ticket_url is null or ticket_url = '';

-- Known corrections for cases where the parsed programme title differs
-- from the canonical EdFringe URL slug.
update public.events
set ticket_url = 'https://www.edfringe.com/tickets/whats-on/artificially-intelligent-procrastinating-pundit'
where (
    lower(title) like '%artificially intelligent procrastinating%'
    or lower(title) like '%artifically intelligent provrastinating%'
  )
  and signal_score > 2
  and (
    (date = date '2026-08-14' and start >= time '18:00')
    or date = date '2026-08-15'
    or (date = date '2026-08-16' and start <= time '18:00')
  );
