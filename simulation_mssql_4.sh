#!/usr/bin/env bash

TEST_CASE_NUMBER=$1;
USERS_COUNT=$2;

USERS_COUNT_1=$3;
USERS_COUNT_2=$4;
USERS_COUNT_3=$5;
USERS_COUNT_4=$6;

TEST_CASE="";
TEST_CASE_RESULT="";
TEST_CASE_REPORT="";
RESULT_FOLDER="";

case $TEST_CASE_NUMBER in

  1)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#1_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/Simulation#4/TC#1/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/Simulation#4/TC#1/
    RESULT_FOLDER=./jmeter_test_result/MS_SQL/Simulation#4/TC#1/
    ;;

  2)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#2_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/Simulation#4/TC#2/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/Simulation#4/TC#2/
    RESULT_FOLDER=./jmeter_test_result/MS_SQL/Simulation#4/TC#2/
    ;;

  3)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#3_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/Simulation#4/TC#3/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/Simulation#4/TC#3/
    RESULT_FOLDER=./jmeter_test_result/MS_SQL/Simulation#4/TC#3/
    ;;

  4)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#4_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/Simulation#4/TC#4/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/Simulation#4/TC#4/
    RESULT_FOLDER=./jmeter_test_result/MS_SQL/Simulation#4/TC#4/
    ;;

  5)
    TEST_CASE=./jmeter_test_cases/MS_Server/TestCase#5_SQLServer.jmx
    TEST_CASE_RESULT=./jmeter_test_result/MS_SQL/Simulation#4/TC#5/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/MS_SQL/Simulation#4/TC#5/
    RESULT_FOLDER=./jmeter_test_result/MS_SQL/Simulation#4/TC#5/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac

echo "-Jusers_count=$USERS_COUNT \n
      -Test_Case=$TEST_CASE \n
      -Test Report=$TEST_CASE_REPORT \n
      -Jresult_folder=$RESULT_FOLDER \n
      -Jusers_count_tc1=$USERS_COUNT_1 \n
      -Jusers_count_tc2=$USERS_COUNT_2 \n
      -Jusers_count_tc3=$USERS_COUNT_3 \n
      -Jusers_count_tc4=$USERS_COUNT_4 \n"

java -jar ./jmeter/bin/ApacheJMeter.jar \
-Jusers_count=$USERS_COUNT \
-Jresult_folder=$RESULT_FOLDER \
-Jusers_count_tc1=$USERS_COUNT_1 \
-Jusers_count_tc2=$USERS_COUNT_2 \
-Jusers_count_tc3=$USERS_COUNT_3 \
-Jusers_count_tc4=$USERS_COUNT_4 \
 -n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT