#!/usr/bin/env bash

TEST_CASE_NUMBER=${1};
USERS_COUNT=${2};
POOL_SIZE=${3};
CONNECTION_WAIT=${4};
TIME=${5};

USERS_COUNT_1=${6};
USERS_COUNT_2=${7};
USERS_COUNT_3=${8};
USERS_COUNT_4=${9};

POOL_SIZE_TC1=${10};
POOL_SIZE_TC2=${11};
POOL_SIZE_TC3=${12};
POOL_SIZE_TC4=${13};

TEST_CASE="";
TEST_CASE_RESULT="";
TEST_CASE_REPORT="";
RESULT_FOLDER="";
case $TEST_CASE_NUMBER in

  1)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#1_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#1/TC#1/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#1/TC#1/
    RESULT_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#1/TC#1/
    ;;

  2)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#2_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#1/TC#2/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#1/TC#2/
    RESULT_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#1/TC#2/
    ;;

  3)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#3_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#1/TC#3/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#1/TC#3/
    RESULT_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#1/TC#3/
    ;;

  4)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#4_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#1/TC#4/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#1/TC#4/
    RESULT_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#1/TC#4/
    ;;

  5)
    TEST_CASE=./jmeter_test_cases/PostgreSQL/TestCase#5_Postgre.jmx
    TEST_CASE_RESULT=./jmeter_test_result/PostgreSQL/Simulation#1/TC#5/general_test_result.jtl
    TEST_CASE_REPORT=./jmeter_reports/PostgreSQL/Simulation#1/TC#5/
    RESULT_FOLDER=./jmeter_test_result/PostgreSQL/Simulation#1/TC#5/
    ;;

  *)
    echo "No test case was found!!"
    exit;
    ;;
esac

echo "-Jusers_count=$USERS_COUNT \n
      -Jpool_size=$POOL_SIZE \n
      -Jconnection_wait=$CONNECTION_WAIT \n
      -Time=$TIME \n
      -Test_Case=$TEST_CASE \n
      -Test Report=$TEST_CASE_REPORT \n
      -Jresult_folder=$RESULT_FOLDER \n
      -Jusers_count_tc1=$USERS_COUNT_1 \n
      -Jusers_count_tc2=$USERS_COUNT_2 \n
      -Jusers_count_tc3=$USERS_COUNT_3 \n
      -Jusers_count_tc4=$USERS_COUNT_4 \n
      -Jpool_size_tc1=$POOL_SIZE_TC1 \n
      -Jpool_size_tc2=$POOL_SIZE_TC2 \n
      -Jpool_size_tc3=$POOL_SIZE_TC3 \n
      -Jpool_size_tc4=$POOL_SIZE_TC4 \n\"

java -jar ./jmeter/bin/ApacheJMeter.jar \
-Jusers_count=$USERS_COUNT \
-Jresult_folder=$RESULT_FOLDER \
-Jpool_size=$POOL_SIZE \
-Jconnection_wait=$CONNECTION_WAIT \
-Jtime=$TIME \
-Jusers_count_tc1=$USERS_COUNT_1 \
-Jusers_count_tc2=$USERS_COUNT_2 \
-Jusers_count_tc3=$USERS_COUNT_3 \
-Jusers_count_tc4=$USERS_COUNT_4 \
-Jpool_size_tc1=$POOL_SIZE_TC1 \
-Jpool_size_tc2=$POOL_SIZE_TC2 \
-Jpool_size_tc3=$POOL_SIZE_TC3 \
-Jpool_size_tc4=$POOL_SIZE_TC4 \
 -n -f -t $TEST_CASE -l $TEST_CASE_RESULT -e -o $TEST_CASE_REPORT