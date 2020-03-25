--Script Select only script:    
--scaling factor: 1000    

do $$
    declare p_aid int := round(random()*100000000);
        declare p_abalance int;
    begin
        SELECT abalance into p_abalance FROM pgbench_accounts WHERE aid = p_aid;
    end
$$ language plpgsql;