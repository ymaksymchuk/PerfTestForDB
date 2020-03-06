---------------TEST Case #2
--Script Select only script:
        
DECLARe @aid INTEGER = ROUND(RAND()*100000*1000, 0),
		@abalance int

SELECT @abalance = abalance FROM pgbench_accounts WHERE aid = @aid;

