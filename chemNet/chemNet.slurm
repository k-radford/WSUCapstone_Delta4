#!/bin/bash
#
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
#SBATCH -J chemNet
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p normal
#SBATCH -o chemNet.%jo
#SBATCH -e chemNet.%je
#SBATCH -t 05:00:00
#SBATCH -A TG-CHE190077

#------------------------------------------------------

echo "ChemNetworks 2.0 Workflow Submission Id : #${SLURM_JOBID}"
echo " "
echo "Inputs: $@"
INPUTS=$@

module load launcher

#grab job execution strings
IFS=', ' read -r -a JOB <<< $2

#run tests
for j in "${!JOB[@]}"
do
        mkdir Job$j
        cp ${JOB[j]} Job$j
        cd Job$j
        echo "Making new job directory..."
        pwd
        echo "Submitting Job $j: ${JOB[j]}"
        time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe ${JOB[j]} &
        PIDS+=($!)
        cd ..
done

echo " "
j=0
for pid in ${PIDS[@]}; do
        echo "waiting for #$j pid = ${pid}"
        wait ${pid}
        STATUS+=($?)
        status=$?
        if test $status -eq 0; then
                echo "Job $j completed"
                PASSED+=($j)
        else
                echo "Job $j failed to execute"
                FAILED+=($j)
        fi
        ((j+=1))

done


echo " "
echo "PASSED    FAILED"
for (( i = 0; i <= $1; i++ )); do
        echo "${PASSED[i]}      ${FAILED[i]}"
done

exit
