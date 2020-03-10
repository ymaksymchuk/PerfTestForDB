#!/usr/bin/env bash
# TODO: Distributed mode
TEST_CASE_NUMBER=$1;
USERS_COUNT=$2;
RAMP_UP=$3;
LOOPS=$4;

# Next params needed only for a TestCase#5
USERS_COUNT_1=$5;
USERS_COUNT_2=$6;
USERS_COUNT_3=$7;
USERS_COUNT_4=$8;

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

  5)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#5_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/TC#5/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/TC#5/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac
echo "n\ ###########################################################################\n"
echo "java -jar ./jmeter/bin/ApacheJMeter.jar \n
-Jusers_count=$USERS_COUNT \n
-Jramp_up=$RAMP_UP \n
-Jloops=$LOOPS \n
-Jusers_count_1=$USERS_COUNT_1 -Jusers_count_2=$USERS_COUNT_2 -Jusers_count_3=$USERS_COUNT_3 -Jusers_count_4=$USERS_COUNT_4 \n
-n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT"
echo "\n ########################################################################### \n"

java -jar ./jmeter/bin/ApacheJMeter.jar \
-Jusers_count=$USERS_COUNT \
-Jramp_up=$RAMP_UP \
-Jloops=$LOOPS \
-Jusers_count_1=$USERS_COUNT_1 \
-Jusers_count_2=$USERS_COUNT_2 \
-Jusers_count_3=$USERS_COUNT_3 \
-Jusers_count_4=$USERS_COUNT_4 \
-n -r -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT