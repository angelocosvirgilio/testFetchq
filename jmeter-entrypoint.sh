#!/bin/bash

folder="${testPlanName}_${version}"
# Destroy and recreate folder
rm -rf ./load-test-results/$folder 
mkdir -p ./load-test-results/$folder/logs
mkdir -p ./load-test-results/$folder/dashboard

# Lancia JMeter
jmeter -n -t jmeter/testplans/$testPlanNameFile.jmx -l load-test-results/$folder/logs/log.jtl -e -o load-test-results/$folder/dashboard/ -JappendDocEnabled=$appendDocEnabled -JpickDocEnabled=$pickDocEnabled -JdocsNumber=$rowsNumber -JjsonFilePath=$jsonFilePath -JpostgresContainerName=$postgres_name
