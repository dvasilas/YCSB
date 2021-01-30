#!/bin/bash

if [ "$TYPE" = "run" ]; then
  ./wait-for-it/wait-for-it.sh --host=${PROTEUSHOST} --port=${PROTEUSPORT} --timeout=0
fi
./wait-for-it/wait-for-it.sh --host=${MONGOHOST} --port=${MONGOPORT} --timeout=0

cd ${YCSB_DIR}

./bin/ycsb ${TYPE} mongodb \
  -P ./workloads/workloada \
  -p table=ycsbbuck \
  -threads ${THREADS} \
  -p warmuptime=${WARMUPTIME} \
  -p maxexecutiontime=${EXECUTIONTIME} \
  -p attributecardinality=${CARDINALITY} \
  -p fieldcount=${FIELDCOUNT} \
  -p connpoolsize=${POOLSIZE} \
  -p mongodb.url=${MONGOURL} \
  -p proteus.host=${PROTEUSHOST} \
  -p proteus.port=${PROTEUSPORT} \
  -p recordcount=${RECORDCOUNT} \
  -p insertstart=${INSERTSTART} \
  -p insertcount=${INSERTCOUNT} \
  -p queryproportion=${QUERYPROPORTION} \
  -p updateproportion=${UPDATEPROPORTION} \
  -p insertproportion=${INSERTPROPORTION} \
  -p client=${CLIENTID} \
  -s > /ycsb/${OUTPUT_FILE_NAME}.txt

if [ "$TYPE" = "run" ]; then
  cp QUERY.hdr /ycsb/QUERY_${OUTPUT_FILE_NAME}.hdr
  # cp FRESHNESS_LATENCY.hdr ${MEASUREMENT_RESULTS_DIR}/FRESHNESS_LATENCY_${OUTPUT_FILE_NAME}.hdr
fi