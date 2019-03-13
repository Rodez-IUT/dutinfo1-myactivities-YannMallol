

create or replace function get_default_owner() returns "user" as $$
	DECLARE
		defaultOwner "user"%rowtype;
		defaultOwnerUsername varchar(500) := 'Default Owner';
	BEGIN
		select * into defaultOwner from "user" 
		    where username = defaultOwnerUsername;
		if not found then
	    	insert into "user" (id,username) 
	    	values (nextval('id_generator'),defaultOwnerUsername); 
	    Select * into defaultOwner from "user"
	        where username = defaultOwnerUsername;
	end if;
	return defaultOwner;
	
	END
$$ language plpgsql;