#!/usr/bin/env bash

#!/usr/bin/env bash

TEST_CASE_NUMBER=$1;
USERS_COUNT=$2;
TEST_CASE="";
TEST_CASE_RESULT="";
TEST_CASE_REPORT="";

case $TEST_CASE_NUMBER in

  1)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#1_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/TC#1/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/TC#1/
    ;;

  2)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#2_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/TC#2/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/TC#2/
    ;;

  3)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#3_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/TC#3/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/TC#3/
    ;;

  4)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#4_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/TC#4/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/TC#4/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac
echo "java -jar ./jmeter/bin/ApacheJMeter.jar -Jusers_count=$USERS_COUNT -n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT"
java -jar ./jmeter/bin/ApacheJMeter.jar -Jusers_count=$USERS_COUNT  -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT