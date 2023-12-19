#!/bin/bash

set -e
set -x
qgraphFile=$1
butlerConfig=$2
${DAF_BUTLER_DIR}/bin/butler --long-log --log-level=VERBOSE transfer-from-graph ${qgraphFile} ${butlerConfig} --register-dataset-types --update-output-chain --transfer-dimensions
