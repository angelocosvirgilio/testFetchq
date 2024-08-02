#!/bin/bash

# Define the container name
CONTAINER_NAME="testfetchq_pgsqldb_1"

# Define the output log file
LOG_FILE="postgres_stats_big_payload.log"

# Infinite loop to log stats every 100ms
while true; do
  # Get the current date and time with milliseconds
  DATE_TIME=$(date +'%Y-%m-%d %H:%M:%S.%3N')
  
  # Get the docker stats output for CPU and memory usage
  STATS=$(docker stats $CONTAINER_NAME --no-stream --format "{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}")
  
  # Write the date, time, and stats to the log file
  echo -e "$DATE_TIME\t$STATS" >> $LOG_FILE
  #sleep 0.1
done
