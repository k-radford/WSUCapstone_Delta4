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
#SBATCH -J launcherB
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -p normal
#SBATCH -o launcherB.%jo
#SBATCH -e launcherB.%je
#SBATCH -t 01:00:00
#SBATCH -A TG-CHE190077

#------------------------------------------------------

module load launcher


for task in 1 2 3 4
do

for index in {1..4}
do

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test$task

case $task in
        1)ARGS="wat${index}.xyz" ;;
	2)ARGS="wat${index}.xyz solB1.xyz" ;;
        3)ARGS="wat${index}.xyz solB1.xyz solC1.xyz" ;;
        4)ARGS="wat${index}.xyz solC1.xyz solB1.xyz" ;;

esac


echo "running test $task.${index}"

/home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test$task $ARGS &
PIDS+=($!)
echo "executing pid = $!"

done
done

for pid in ${PIDS[@]}; do
        echo "waiting for pid = ${pid}"
        wait ${pid}
        STATUS+=($?)
	echo "status = $?"

done


i=0
for st in ${STATUS[@]}; do
        if [[ ${st} -ne 0 ]]; then
                echo "$i executed"
                echo ""
        else
                echo "$i failed to execute"
        fi
        ((i+=1))
done

