#!/bin/bash

##SBATCH --partition=rubin
#SBATCH --job-name=calib
#SBATCH --output=/sdf/home/a/abrought/run6/output/out3.txt
#SBATCH --error=/sdf/home/a/abrought/run6/output/err3.txt
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=32G
##SBATCH --time=5:00:00


source ~/run6-setup.sh

 
export REPO=/repo/ir2
export CONFIG=/sdf/home/a/abrought/run6/config

pipetask run  \
    -j 25 \
    -d "instrument='LSSTCam' AND detector=23 AND exposure.science_program IN ('13511')  AND exposure IN (2023110500063)" \
    -b ${REPO} \
    -i u/abrought/ptc.13511.basic.doLinearizeFalse,LSSTCam/photodiode,LSSTCam/raw/all \
    -o u/abrought/linearity.13511 \
    -p $CP_PIPE_DIR/pipelines/LsstCam/cpLinearityCorrected.yaml \
    --register-dataset-types
    
