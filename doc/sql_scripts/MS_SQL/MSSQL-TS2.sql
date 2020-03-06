---------------TEST Case #2

--Script, read-write:

DECLARE @aid INTEGER = ROUND(RAND()*100000*1000, 0)
DECLARE @bid INTEGER = ROUND(RAND()*1*1000, 0) 
DECLARE @tid INTEGER = ROUND(RAND()*10*1000, 0) 
DECLARE @delta INTEGER = ROUND(RAND()*10*1000-5000, 0),
		@abalance int

BEGIN;
	UPDATE pgbench_accounts SET abalance = abalance + @delta WHERE aid = @aid;
	SELECT @abalance = abalance FROM pgbench_accounts WHERE aid = @aid;
	UPDATE pgbench_tellers SET tbalance = tbalance + @delta WHERE tid = @tid;
	UPDATE pgbench_branches SET bbalance = bbalance + @delta WHERE bid = @bid;
	INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (@tid, @bid, @aid, @delta, CURRENT_TIMESTAMP);
END;

