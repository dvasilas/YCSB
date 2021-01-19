#!/bin/bash

if [ "$TYPE" = "run" ]; then
  ./wait-for-it/wait-for-it.sh --host=${PROTEUSHOST} --port=${PROTEUSPORT} --timeout=0
fi
./wait-for-it/wait-for-it.sh --host=${S3HOST} --port=${S3PORT} --timeout=0

cd ${YCSB_DIR}

./bin/ycsb ${TYPE} s3 \
  -P ./workloads/${WORKLOAD} \
  -p table=${TABLE} \
  -threads ${THREADS} \
  -p maxexecutiontime=${EXECUTIONTIME} \
  -p warmuptime=${WARMUPTIME} \
  -p proteus.host=${PROTEUSHOST} \
  -p proteus.port=${PROTEUSPORT} \
  -p s3.endPoint=http://${S3HOST}:${S3PORT}  \
  -p s3.accessKeyId=${S3ACCESSKEYID} \
  -p s3.secretKey=${S3SECRETKEY} \
  -p recordcount=${RECORDCOUNT} \
  -p insertstart=${INSERTSTART} \
  -p insertcount=${INSERTCOUNT} \
  -p queryproportion=${QUERYPROPORTION} \
  -p updateproportion=${UPDATEPROPORTION} \
  -p insertproportion=${INSERTPROPORTION} \
  -p client=${CLIENTID} \
  -s > ${MEASUREMENT_RESULTS_DIR}/${OUTPUT_FILE_NAME}.txt

if [ "$TYPE" = "run" ]; then
  cp QUERY.hdr ${MEASUREMENT_RESULTS_DIR}/QUERY_${OUTPUT_FILE_NAME}.hdr
  # cp FRESHNESS_LATENCY.hdr ${MEASUREMENT_RESULTS_DIR}/FRESHNESS_LATENCY_${OUTPUT_FILE_NAME}.hdr
fi