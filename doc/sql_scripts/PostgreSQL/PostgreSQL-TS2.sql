---------------TEST Case #2

--Script, read-write:

  

do $$
	declare p_aid int := round(random()*100000000); 
	declare p_bid int := round(random()*1000); 
	declare p_tid int := round(random()*10000); 
	declare p_delta int := round(random()*10000)-5000; 
	declare p_abalance int;
begin
	-- body
	UPDATE pgbench_accounts SET abalance = abalance + p_delta WHERE aid = p_aid;
	SELECT abalance into p_abalance FROM pgbench_accounts WHERE aid = p_aid;
	UPDATE pgbench_tellers SET tbalance = tbalance + p_delta WHERE tid = p_tid;
	UPDATE pgbench_branches SET bbalance = bbalance + p_delta WHERE bid = p_bid;
	INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (p_tid, p_bid, p_aid, p_delta, CURRENT_TIMESTAMP);	

end
$$ language plpgsql;

