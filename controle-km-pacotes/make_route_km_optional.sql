alter table public.routes
  alter column onix_km_initial drop not null,
  alter column onix_km_final drop not null,
  alter column onix_km drop not null,
  alter column logan_km_initial drop not null,
  alter column logan_km_final drop not null,
  alter column logan_km drop not null;

do $$
begin
  if not exists (
    select 1 from pg_constraint
    where conname = 'routes_onix_km_values_check'
      and conrelid = 'public.routes'::regclass
  ) then
    alter table public.routes
      add constraint routes_onix_km_values_check check (
        (onix_km_initial is null and onix_km_final is null and onix_km is null)
        or (onix_km_initial is not null and onix_km_final is not null and onix_km is not null)
      );
  end if;

  if not exists (
    select 1 from pg_constraint
    where conname = 'routes_logan_km_values_check'
      and conrelid = 'public.routes'::regclass
  ) then
    alter table public.routes
      add constraint routes_logan_km_values_check check (
        (logan_km_initial is null and logan_km_final is null and logan_km is null)
        or (logan_km_initial is not null and logan_km_final is not null and logan_km is not null)
      );
  end if;
end;
$$;