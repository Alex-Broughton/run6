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
export LINEARITY=u/cslage/linearizer_28jan22/20220128T174703Z
export CTI=u/abrought/BF/2023.04.14/cti.2023.04.14

pipetask run  \
    -j 5 \
    -d "instrument='LSSTCam' AND detector IN (23) AND exposure.science_program IN ('13511')  AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
    -b ${REPO} \
    -i u/abrought/ptc.13511.complete,u/cslage/linearizer_28jan22/20220128T174703Z,u/abrought/cti.2023.11.29.DM-41754_and_DM-41911,u/lsstccs/defects_13505_w_2023_41/20231104T224625Z,u/lsstccs/flat_13505_w_2023_41/20231104T223548Z,u/lsstccs/dark_13505_w_2023_41/20231104T222709Z,u/lsstccs/bias_13505_w_2023_41/20231104T221805Z,u/lsstccs/bias_13505_w_2023_41/20231104T163511Z,LSSTCam/raw/all,LSSTCam/calib,LSSTCam/photodiode \
    -o u/abrought/ptc.13511.test.3 \
    -p $CP_PIPE_DIR/pipelines/_ingredients/cpPtc-complete-solver.yaml \
    --register-dataset-types \
    --skip-existing
    
