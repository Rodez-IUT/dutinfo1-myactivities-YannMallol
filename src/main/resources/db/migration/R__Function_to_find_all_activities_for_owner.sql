create or replace function find_all_activities_for_owner(ownername varchar(500) ) returns SETOF activity AS $$
select act.* FROM activity act JOIN "user" owner  on owner_id=owner.id WHERE owner.username = ownername;
$$ LANGUAGE SQL; 