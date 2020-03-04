#!/usr/bin/env bash

TEST_CASE_NUMBER=$1;
USERS_COUNT=$2;
TEST_CASE="";
TEST_CASE_RESULT="";
TEST_CASE_REPORT="";

case $TEST_CASE_NUMBER in

  1)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#1_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/TC#1/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/TC#1/
    ;;

  2)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#2_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/TC#2/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/TC#2/
    ;;

  3)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#3_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/TC#3/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/TC#3/
    ;;

  4)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/TC#4/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/TC#4/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac
echo "java -jar ./jmeter/bin/ApacheJMeter.jar -Jusers_count=$USERS_COUNT -n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT"
java -jar ./jmeter/bin/ApacheJMeter.jar -Jusers_count=$USERS_COUNT  -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT