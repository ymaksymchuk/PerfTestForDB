# VIA Perf

## Supported Platforms
* Windows 10 (sub system linux) with shell
* Mac OS
* Linux

## Table of contents
1. Project structure
2. Configuring test project
3. Running tests
4. Reporting
5. Results and reports
6. Metrics

## 1. Project structure

The solution is designed to be the Performance test framework for databases
PostgreSQL and Microsoft SQL Server.

### Folders

- doc \
include all scripts and additional documents for the test or reports etc.

- jmeter \
in this folder full installed and suited Apache Jmeter with all necessary plugins

- jmeter_reports \

- jmeter_test_case \

- jmeter_test_result \

## 2. Configuring test project

- Clone current project to the local machine or remote server \
what will be used for the test run
```
git clone https://github.com/ymaksymchuk/PerfTestForDB.git 
```

- Install Java 8 or higher 
```
https://adoptopenjdk.net/releases.html
```

## 3. Test case explanation

### Microsoft SQL Server

- Test case #1
In scope of test will be run sql script form the file 
```
doc/sql_scripts/MS_SQL/MSSQL-TS1.sql
```
- Test case #2
In scope of test will be run sql script form the file 
```
doc/sql_scripts/MS_SQL/MSSQL-TS2.sql
```
- Test case #3
Before run this test as an automation performance test please execute manually  
```
doc/sql_scripts/MS_SQL/MSSQL-TS3_part_01.sql
```
In scope of test will be execute sql script
```
doc/sql_scripts/MS_SQL/MSSQL-TS3_part_02.sql
```
- Test case #4
```
doc/sql_scripts/MS_SQL/MSSQL-TS4.sql
```
- Test case #5
In scope of test will be run all test described before  

### PostgreSQL

- Test case #1:
In scope of test will be run sql script form the file 
```
doc/sql_scripts/PostgreSQL/PostgreSQL-TS1.sql
```
- Test case #2:
In scope of test will be run sql script form the file 
```
doc/sql_scripts/PostgreSQL/PostgreSQL-TS2.sql
```
- Test case #3:
Before run this test as an automation performance test please execute manually  
```
doc/sql_scripts/PostgreSQL/PostgreSQL-TS3_part_01.sql   
```
In scope of test will be execute sql script
```
doc/sql_scripts/PostgreSQL/PostgreSQL-TS1.sql
```
- Test case #4:
In scope of test will be run sql script form the file 
```
doc/sql_scripts/PostgreSQL/PostgreSQL-TS4.sql
```
- Test case #5
In scope of test will be run all test described before  


## 4. Running tests
#### To run test on your locl pc you can run 
```
java -jar ./jmeter/bin/ApacheJMeter.jar 
```
And open testcase what you want to run manually from the folder
```
./jmeter_test_cases/*
```
#### To run test on remote server *nix like
```
sh simulation_<your database>_<simulation number>.sh 1 50 20 10000 300   
```

where:
* first argument number of test case
* second argument amount of users
* third  argument amount of connections in connection pool
* forth  max time what jmeter thread will wait on jdbc connection before throw exception
* five argument time of test execution in millisecond  

#### To run test case 5 use next command 
```
sh simulation_postgresql_1.sh <TC number> 0 0 <Connection time wait> <Time of execution> <Amount of users for tc1>  <Amount of users for tc2> <Amount of users for tc3> <Amount of users for tc4> <Connection pool size for tc1> <Connection pool size for tc2> <Connection pool size for tc3> <Connection pool size for tc4>
```
example: 
```
sh simulation_postgresql_1.sh 5 0 0 10000 180 50 75 75 50 20 50 50 20
```

### 5. Results and reports
Report can be found after test execution in:
```
./jmeter_reports/<DataBase>/Simulation#<Number of simulation>/TC#<Number of test case>/
```
Result for diagram creation can be found in:
```
./jmeter_test_result/<DataBase>/Simulation#<Number of simulation>/TC#<Number of test case>/general_test_result.jtl
```

### 6. Metrics
For Windows we are using Performance monitor to find system metrics \
For *nix we are using ``run_sar.sh`` script 
to save in file all sar statistic information
```
sh run_sar.sh <Simulation number> <Test case number>
```