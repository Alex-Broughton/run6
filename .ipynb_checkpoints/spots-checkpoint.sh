#!/bin/bash

##SBATCH --partition=rubin
#SBATCH --job-name=calib
#SBATCH --output=/sdf/home/a/abrought/run6/output/out4.txt
#SBATCH --error=/sdf/home/a/abrought/run6/output/err4.txt
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=32G
##SBATCH --time=5:00:00


source ~/forked-setup.sh
export PYTHONPATH="/sdf/home/a/abrought/alternate_branches/mixcoatl/python:${PYTHONPATH}" # Needed for using gridFit

pip install pyfftw

export REPO=/repo/main
export CONFIG=/sdf/home/a/abrought/alternate_branches/forked/cp_pipe/pipelines/_ingredients
export SBIAS=u/cslage/calib/13144/bias_20211229
export SDARK=u/cslage/calib/13144/dark_20211229
export DEFECTS=u/cslage/calib/13144/defects_20211229
export LINEARITY=u/cslage/linearizer_28jan22/20220128T174703Z
#export CTI=u/abrought/BF/2023.04.14/cti.2023.04.14

# pipetask run \
#         -j 30 \
#         -d "instrument='LSSTCam' AND detector in ( 23 ) AND exposure.observation_type='flat' AND exposure.science_program IN ('13144')" \
#         -b ${REPO} \
#         -i u/abrought/BF/2023.05.15/bfk.2023.05.15.R03-S12.final,${SBIAS},${SDARK},${DEFECTS},${LINEARITY},LSSTCam/raw/all \
#         -o u/abrought/BF/2023.12.13/cti.2023.12.13 \
#         -p ${CONFIG}/cpDeferredCharge.yaml \
#             --config isr:connections.newBFKernel='bfk' \
#         --register-dataset-types

export CTI=u/abrought/BF/2023.12.13/cti.2023.12.13

pipetask run \
        -j 30 \
        -d "instrument='LSSTCam' AND detector in ( 23 ) AND exposure.observation_type='spot' AND exposure.science_program IN ('13248')" \
        -b ${REPO} \
        -i u/abrought/BF/2023.07.19/ptc.2023.07.19.R03-S12.trunc_to_pcti.fullnoisematrix,u/abrought/BF/2023.05.15/bfk.2023.05.15.R03-S12.final,${SBIAS},${SDARK},${DEFECTS},${CTI},${LINEARITY},LSSTCam/raw/all \
        -o u/abrought/BF/2023.12.13/run_13248/R03-S12/corrected.A23 \
        -p ${CONFIG}/cpSpots.yaml \
            --config isr:connections.newBFKernel='bfk' \
        --register-dataset-types

pipetask run \
        -j 30 \
        -d "instrument='LSSTCam' AND detector in ( 23 ) AND exposure.observation_type='spot' AND exposure.science_program IN ('13247')" \
        -b ${REPO} \
        -i u/abrought/BF/2023.07.19/ptc.2023.07.19.R03-S12.trunc_to_pcti.fullnoisematrix,u/abrought/BF/2023.05.15/bfk.2023.05.15.R03-S12.final,${SBIAS},${SDARK},${DEFECTS},${CTI},${LINEARITY},LSSTCam/raw/all \
        -o u/abrought/BF/2023.12.13/run_13247/R03-S12/corrected.A23 \
        -p ${CONFIG}/cpSpots.yaml \
            --config isr:connections.newBFKernel='bfk' \
        --register-dataset-types
        
pipetask run \
        -j 30 \
        -d "instrument='LSSTCam' AND detector in ( 112 ) AND exposure.observation_type='spot' AND exposure.science_program IN ('13251')" \
        -b ${REPO} \
        -i u/abrought/BF/2023.07.19/ptc.2023.07.19.R03-S12.trunc_to_pcti.fullnoisematrix,u/abrought/BF/2023.05.15/bfk.2023.05.15.R03-S12.final,${SBIAS},${SDARK},${DEFECTS},${CTI},${LINEARITY},LSSTCam/raw/all \
        -o u/abrought/BF/2023.12.13/run_13251/R03-S12/corrected.A23 \
        -p ${CONFIG}/cpSpots.yaml \
            --config isr:connections.newBFKernel='bfk' \
        --register-dataset-types

pipetask run \
        -j 30 \
        -d "instrument='LSSTCam' AND detector in ( 112 ) AND exposure.observation_type='spot' AND exposure.science_program IN ('13252')" \
        -b ${REPO} \
        -i u/abrought/BF/2023.07.19/ptc.2023.07.19.R03-S12.trunc_to_pcti.fullnoisematrix,u/abrought/BF/2023.05.15/bfk.2023.05.15.R24-S11.final,${SBIAS},${SDARK},${DEFECTS},${CTI},${LINEARITY},LSSTCam/raw/all \
        -o u/abrought/BF/2023.12.13/run_13252/R24-S11/corrected.A23 \
        -p ${CONFIG}/cpSpots.yaml \
            --config isr:connections.newBFKernel='bfk' \
        --register-dataset-types