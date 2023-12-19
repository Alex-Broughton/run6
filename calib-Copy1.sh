#!/bin/bash

##SBATCH --partition=rubin
#SBATCH --job-name=calib
#SBATCH --output=/sdf/home/a/abrought/run5/BF/output/out.txt
#SBATCH --error=/sdf/home/a/abrought/run5/BF/output/err.txt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=5:00:00


source /sdf/group/rubin/sw/tag/w_2023_29/loadLSST.bash
setup lsst_distrib -t w_2023_29
setup -t w_2023_29 -j -r /sdf/home/a/abrought/alternate_branches/dm_stack/cp_pipe
setup -t w_2023_29 -j -r /sdf/home/a/abrought/alternate_branches/dm_stack/ip_isr

export PYTHONPATH="/sdf/home/a/abrought/bin/mixcoatl/python:${PYTHONPATH}" # Needed for using gridFit
 
# Set up repositories for collections
export REPO=/repo/ir2
export CONFIG=/sdf/home/a/abrought/run6/config


pipetask run \
   -j 10 \
   -d "instrument='LSSTCam' AND detector IN (23) AND exposure.science_program IN ('13421') AND exposure.observation_reason='bias' " \
   -b ${REPO} \
   -i LSSTCam/raw/all,LSSTCam/calib \
   -o u/abrought/sbias.2023.08.01 \
   -p ${CONFIG}/cpBias.yaml \
   --register-dataset-types
   
pipetask run \
    -j 25 \
    -d "instrument='LSSTCam' AND exposure.science_program IN ('13421') AND detector in (23) AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
    -b ${REPO} \
    -i u/abrought/sbias.2023.08.01,LSSTCam/raw/all,LSSTCam/calib \
    -o u/abrought/defects.2023.08.01 \
    -p ${CONFIG}/findDefects.yaml \
    --register-dataset-types