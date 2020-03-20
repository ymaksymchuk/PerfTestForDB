#!/usr/bin/env bash

TEST_CASE_NUMBER=$1;
USERS_COUNT=$2;
TIME=$3;
USERS_COUNT_1=$4;
USERS_COUNT_2=$5;
USERS_COUNT_3=$6;
USERS_COUNT_4=$7;

TEST_CASE="";
TEST_CASE_RESULT="";
TEST_CASE_REPORT="";
RESULT_FOLDER="";

case $TEST_CASE_NUMBER in

  1)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#1_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#3/TC#1/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#3/TC#1/
    GRAF_FILE=./jmeter_test_result/PostgreSQL/Simulation#3/TC#1/general_test_result.jtl
    GRAF_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#3/TC#1/
    ;;

  2)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#2_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#3/TC#2/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#3/TC#2/
    GRAF_FILE=./jmeter_test_result/PostgreSQL/Simulation#3/TC#2/general_test_result.jtl
    GRAF_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#3/TC#2/
    ;;

  3)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#3_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#3/TC#3/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#3/TC#3/
    GRAF_FILE=./jmeter_test_result/PostgreSQL/Simulation#3/TC#3/general_test_result.jtl
    GRAF_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#3/TC#3/
    ;;

  4)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#3/TC#4/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#3/TC#4/
    GRAF_FILE=./jmeter_test_result/PostgreSQL/Simulation#3/TC#4/general_test_result.jtl
    GRAF_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#3/TC#4/
    ;;

  5)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#5_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#3/TC#5/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#3/TC#5/
    GRAF_FILE=./jmeter_test_result/PostgreSQL/Simulation#3/TC#5/general_test_result.jtl
    GRAF_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#3/TC#5/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac

echo "-Jusers_count=$USERS_COUNT \n
      -Time=$TIME \n
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
-Jtime=$TIME \
-Jusers_count_tc1=$USERS_COUNT_1 \
-Jusers_count_tc2=$USERS_COUNT_2 \
-Jusers_count_tc3=$USERS_COUNT_3 \
-Jusers_count_tc4=$USERS_COUNT_4 \
 -n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT

