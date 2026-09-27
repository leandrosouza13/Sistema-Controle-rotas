create or replace function public.is_household_member(p_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.household_members as membership
    where membership.household_id = p_household_id
      and membership.user_id = auth.uid()
  );
$$;

revoke all on function public.is_household_member(uuid) from public;
grant execute on function public.is_household_member(uuid) to authenticated;

drop policy if exists "household member read" on public.households;
create policy "household member read" on public.households
  for select to authenticated
  using (public.is_household_member(id));

drop policy if exists "membership read" on public.household_members;
create policy "membership read" on public.household_members
  for select to authenticated
  using (user_id = auth.uid() or public.is_household_member(household_id));

drop policy if exists "routes select" on public.routes;
create policy "routes select" on public.routes
  for select to authenticated
  using (public.is_household_member(household_id));

drop policy if exists "routes insert" on public.routes;
create policy "routes insert" on public.routes
  for insert to authenticated
  with check (created_by = auth.uid() and public.is_household_member(household_id));

drop policy if exists "routes update" on public.routes;
create policy "routes update" on public.routes
  for update to authenticated
  using (public.is_household_member(household_id))
  with check (public.is_household_member(household_id));

drop policy if exists "routes delete" on public.routes;
create policy "routes delete" on public.routes
  for delete to authenticated
  using (public.is_household_member(household_id));