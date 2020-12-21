#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
#SBATCH -J launcher2
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -p normal
#SBATCH -o launcher2.%jo
#SBATCH -e launcher2.%je
#SBATCH -t 01:00:00
#SBATCH -A TG-CHE190077

#------------------------------------------------------

module load launcher

echo "launcher2.slurm: run either two different water files or test numbers"

mkdir /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}

index=1
for task in {2..3}
do

mkdir /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}/$task.${index}

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test$task

cp Input-test$task /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}/$task.${index}

case $task in
        1)ARGS="wat${index}.xyz" ;;
	2)ARGS="wat${index}.xyz solB1.xyz" ;;
        3)ARGS="wat${index}.xyz solB1.xyz solC1.xyz" ;;
        4)ARGS="wat${index}.xyz solC1.xyz solB1.xyz" ;;

esac

cp $ARGS /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}/$task.${index}

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}/$task.${index}

echo "running test$task.${index} for $ARGS"

time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test$task $ARGS &
PIDS+=($!)

done

j=0
for pid in ${PIDS[@]}; do
	echo "waiting for #$j pid = ${pid}"
	wait ${pid}
	STATUS+=($?)
	status=$?
	if test $status -eq 0; then
        	echo "${pid} passed"
        	echo ""
	else
        	echo "${pid} failed"
	fi
	((j+=1))

done


i=0
for st in ${STATUS[@]}; do
	if [[ ${st} -eq 0 ]]; then
        	echo "$i executed"
        	echo ""
	else
        	echo "$i failed to execute"
	fi
	((i+=1))
done

exit

