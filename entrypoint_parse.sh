#!/bin/bash

cd ${YCSB_DIR}
cp /ycsb/QUERY_${PREFIX}*.hdr .
cp /ycsb/UPDATE_${PREFIX}*.hdr .
./bin/ycsb load basic \
  -P workloads/workloada \
  -p recordcount=0 \
  -p attributecardinality=0 \
  -p threads=${THREADS} \
  -p parse=true \
  -p parsePrefix=${PREFIX} \
  > /ycsb/${PREFIX}.txt
