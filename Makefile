SHELL=/bin/bash

version?=4.0.2
rowsNumber?=1000
postgres_name=testfetchq_pgsqldb_1
testPlanName?=test_doc_append_doc_pick
testPlanNameFile?=test_doc_append_doc_pick
appendDocEnabled=1
pickDocEnabled=1
jsonFilePath?=/jmeter/testplans/large_data.json

start: start-postgres reset init_schema config_queues

start_and_seed: start rowsNumber=1000


start-postgres:
	@docker-compose up -d pgsqldb

init_schema:
	docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/fetchq-schema_v${version}.sql

config_queues:
	docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/config_queues.sql

recreate_doc_pick:
	docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/doc_pick_v${version}.sql

test-sql:
	docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/test-script.sql

#seed:	docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/seed.sql -v rows_number=${rowsNumber}

reset:
	@docker exec -i ${postgres_name} psql -U postgres postgres < ./postgres-scripts/clean_schema.sql

check-postgres-running:S
	docker exec -i ${postgres_name} psql pg_isready

new-exec-test:
	@chmod -R +rwx ./load-tests/jmeter/	
	@docker-compose run --rm jmeter jmeter -n -t jmeter/testplans/${testPlanNameFile}.jmx -l load-test-results/${testPlanName}_${version}/logs/log.jtl -e -o  load-test-results/${testPlanName}_${version}/dashboard/ -JappendDocEnabled=${appendDocEnabled} -JpickDocEnabled=${pickDocEnabled} -JdocsNumber=${rowsNumber} -JjsonFilePath=${jsonFilePath} -JpostgresContainerName=${postgres_name}
	
exec-test-o:
	@docker-compose run --rm jmeter ls -l && rm -rf ./load-test-results/${testPlanName}_${version} && mkdir ./load-test-results/${testPlanName}_${version}
	@docker-compose run --rm jmeter jmeter -n -t jmeter/testplans/${testPlanNameFile}.jmx -l load-test-results/${testPlanName}_${version}/logs/log.jtl -e -o  load-test-results/${testPlanName}_${version}/dashboard/ -JappendDocEnabled=${appendDocEnabled} -JpickDocEnabled=${pickDocEnabled} -JdocsNumber=${rowsNumber} -JjsonFilePath=${jsonFilePath} -JpostgresContainerName=${postgres_name}

exec-test:
	@docker-compose run --rm jmeter sh ./jmeter-entrypoint.sh

jmeter-target:
	@docker-compose run --rm jmeter rm -rf ./jmeter/${testPlanName} && mkdir ./jmeter/${testPlanName} 
	@docker-compose run --rm jmeter jmeter -n -t jmeter/testplans/${testPlanNameFile}.jmx -l jmeter/${testPlanName}/logs/log.jtl -e -o  jmeter/${testPlanName}/dashboard/ -JpageSize=50


start-tests: start exec-test


stop:
	@docker-compose down

start-graphana-monitoring:
	@docker-compose up -d cadvisor prometheus grafana

stop-graphana-monitoring:
	@docker-compose down cadvisor prometheus grafana