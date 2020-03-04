#!/usr/bin/env bash

###########################################################################______RUN_WITHOUT UI______#########################################################################################################

___________________________________________________________________________________POSTGRESQL__________________________________________________________________________________________________________________
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/PostgreSQL/TestCase#1_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#1/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#1/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/PostgreSQL/TestCase#2_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#2/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#2/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/PostgreSQL/TestCase#3_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#3/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#3/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#4/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#4/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/PostgreSQL/TestCase#5_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#5/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#5/

___________________________________________________________________________________MS_SQL_SERVER__________________________________________________________________________________________________________________
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/MS_Server/TestCase#1_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#1/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#1/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/MS_Server/TestCase#2_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#2/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#2/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/MS_Server/TestCase#3_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#3/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#3/
#java -jar ./jmeter/bin/ApacheJMeter.jar -n -f -t ./jmeter_test_cases/MS_Server/TestCase#4_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#4/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#4/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#5_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#5/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#5/


###########################################################################______RUN_WITH UI______#########################################################################################################

___________________________________________________________________________________POSTGRESQL__________________________________________________________________________________________________________________
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#1/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#1/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/PostgreSQL/TestCase#2_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#2/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#2/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/PostgreSQL/TestCase#3_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#3/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#3/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#4/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#4/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/PostgreSQL/TestCase#5_Postgre.jmx -l ./jmeter_test_result/PostgreSQL/TC#5/general_test_result.jtl -e -o ./jmeter_reports/PostgreSQL/TC#5/

___________________________________________________________________________________MS_SQL_SERVER__________________________________________________________________________________________________________________
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#1_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#1/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#1/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#2_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#2/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#2/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#3_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#3/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#3/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#4_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#4/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#4/
#java -jar ./jmeter/bin/ApacheJMeter.jar -f -t ./jmeter_test_cases/MS_Server/TestCase#5_SQLServer.jmx -l ./jmeter_test_result/MS_SQL/TC#5/general_test_result.jtl -e -o ./jmeter_reports/MS_SQL/TC#5/
