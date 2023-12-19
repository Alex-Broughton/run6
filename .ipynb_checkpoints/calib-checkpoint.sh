#!/bin/bash

##SBATCH --partition=rubin
#SBATCH --job-name=calib
#SBATCH --output=/sdf/home/a/abrought/run5/BF/output/out.txt
#SBATCH --error=/sdf/home/a/abrought/run5/BF/output/err.txt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=5:00:00


source /sdf/group/rubin/sw/tag/w_2023_44/loadLSST.bash
setup lsst_distrib -t w_2023_44
setup -t w_2023_29 -j -r /sdf/home/a/abrought/alternate_branches/w_2023_44_ctifix/cp_pipe
setup -t w_2023_29 -j -r /sdf/home/a/abrought/alternate_branches/w_2023_44_ctifix/ip_isr

# Set up repositories for collections
export REPO=/repo/ir2
export CONFIG=/sdf/home/a/abrought/run6/config

# pipetask run \
#    -j 10 \
#    -d "instrument='LSSTCam' AND detector IN (23,112) AND exposure.science_program IN ('13505') AND exposure.observation_reason='bias' " \
#    -b ${REPO} \
#    -i LSSTCam/raw/all,LSSTCam/calib \
#    -o u/abrought/sbias.2023.11.08 \
#    -p ${CONFIG}/cpBias.yaml \
#    --register-dataset-types \
#    --skip-existing
   
# pipetask run \
#     -j 25 \
#     -d "instrument='LSSTCam' AND exposure.science_program IN ('13505') AND detector in (23,112) AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
#     -b ${REPO} \
#     -i u/abrought/sbias.2023.11.08,LSSTCam/raw/all,LSSTCam/calib \
#     -o u/abrought/defects.2023.11.08 \
#     -p ${CONFIG}/findDefects.yaml \
#     --register-dataset-types \
#    --skip-existing
    
# pipetask run \
#     -j 25 \
#     -d "instrument='LSSTCam' AND exposure.science_program IN ('13505') AND detector in (23,112) AND exposure.observation_type = 'dark' AND exposure.observation_reason='dark' " \
#     -b ${REPO} \
#     -i u/abrought/defects.2023.11.08,u/abrought/sbias.2023.11.08,LSSTCam/raw/all,LSSTCam/calib \
#     -o u/abrought/sdark.2023.11.08 \
#     -p ${CONFIG}/cpDark.yaml \
#     --register-dataset-types \
#    --skip-existing
    
# pipetask run \
#     -j 25 \
#     -d "instrument='LSSTCam' AND exposure.science_program IN ('13491') AND detector in (23,112) AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
#     -b ${REPO} \
#     -i u/abrought/sdark.2023.11.08,u/abrought/defects.2023.11.08,u/abrought/sbias.2023.11.08,LSSTCam/raw/all,LSSTCam/calib \
#     -o u/abrought/sflat.run13491.2023.11.08.hvbiasoff \
#     -p ${CONFIG}/cpFlat.yaml \
#     --register-dataset-types \
#    --skip-existing
    
# pipetask run \
#     -j 25 \
#     -d "instrument='LSSTCam' AND exposure.science_program IN ('13491') AND detector in (23,112) AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
#     -b ${REPO} \
#     -i ${bias},${dark},${defects},LSSTCam/raw/all,LSSTCam/calib \
#     -o u/abrought/sflat.run13491.2023.11.08.hvbiasoff \
#     -p ${CONFIG}/cpDark.yaml \
#     --register-dataset-types

pipetask run \
    -j 32 \
    -d "detector IN (23) AND instrument='LSSTCam' AND exposure.science_program IN ('13511')  AND exposure.observation_type = 'flat' AND exposure.observation_reason='flat' " \
    -b ${REPO} \
    -i LSSTCam/calib/DM-36442/linearity.20221026a,u/abrought/cti.2023.11.08,u/lsstccs/defects_13505_w_2023_41/20231104T224625Z,u/lsstccs/flat_13505_w_2023_41/20231104T223548Z,u/lsstccs/dark_13505_w_2023_41/20231104T222709Z,u/lsstccs/bias_13505_w_2023_41/20231104T221805Z,u/lsstccs/bias_13505_w_2023_41/20231104T163511Z,LSSTCam/raw/all,LSSTCam/calib,LSSTCam/photodiode \
    -o u/abrought/cti.2023.11.16 \
    -p ${CONFIG}/cpDeferredCharge-old.yaml \
    --register-dataset-types
