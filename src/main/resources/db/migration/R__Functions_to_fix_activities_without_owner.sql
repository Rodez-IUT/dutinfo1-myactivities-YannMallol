

create or replace function get_default_owner() returns "user" as $$
	DECLARE
		defaultOwner "user"%rowtype;
		defaultOwnerUsername varchar(500) := 'Default Owner';
	BEGIN
		select * into defaultOwner from "user" 
		    where username = defaultOwnerUsername;
		if not found then
	    	insert into "user" (id, username) 
	    	values (nextval('id_generator'),defaultOwnerUsername); 
	    Select * into defaultOwner from "user"
	        where username = defaultOwnerUsername;
	end if;
	return defaultOwner;
	
	END
$$ language plpgsql;


/* 1) cherhcher les activtes sans "owner"
 * Attribuer à ses activités le "defaultOwner";
 * Retourner les activités modifiées
 */	
 
 
 
 
 create or replace function fix_activities_without_owner() returns setof activity as $$
	DECLARE
	    defaultOwner "user"%rowtype;
		nowDate date = now();                                              
	BEGIN
		defaultOwner := get_default_owner();
		return query
		    update activity
		    set owner_id = defaultOwner.id,
		    modification_date = nowDate
		where owner_id IS NULL
		returning *;
	    
	END
$$ language plpgsql;
	