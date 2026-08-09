alter table public.events
add column if not exists ticket_url text;

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

-- Known correction from the parsed programme title.
update public.events
set ticket_url = 'https://www.edfringe.com/tickets/whats-on/artificially-intelligent-procrastinating-pundit'
where lower(title) like '%artificially intelligent procrastinating%'
   or lower(title) like '%artifically intelligent provrastinating%';
