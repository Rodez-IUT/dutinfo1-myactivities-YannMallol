DROP TRIGGER IF EXISTS log_delete_activity on activity;

CREATE OR REPLACE FUNCTION log_delete_activity()
    returns trigger as $$
BEGIN 
    INSERT INTO action_log(if,action_name,entity_name,entity_id,author,action_date)
    values (nextval('id_generator'),'delete','activity',OLD.id, user, now());
    return null; --Le resultat est ignore car il s'agit d'un trigger after
END;
$$language plpgsql;


CREATE TRIGGER log_delete_activity
    after delete on activity
    for each row execute procedure log_delete_activity();