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
#SBATCH -J launcherAurora
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -p normal
#SBATCH -o launcherAurora.%jo
#SBATCH -e launcherAurora.%je
#SBATCH -t 01:00:00
#SBATCH -A TG-CHE190077

#------------------------------------------------------

module load launcher

for index in {1..100}
do

for task in 1 2 3 4
do

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test$task

case $task in
        1)ARGS="wat${index}.xyz" ;;
        2)ARGS="wat${index}.xyz solB1.xyz" ;;
        3)ARGS="wat${index}.xyz solB1.xyz solC1.xyz" ;;
        4)ARGS="wat${index}.xyz solC1.xyz solB1.xyz" ;;

esac


echo "running test $task.${index}"

time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test$task $ARGS &

file="./test-jobs/test$task/Input-test$task.wat${index}.xyz.wat${index}.xyz.Graph"
if [ -e "$file" ]
then
        echo "test $task.${index} executed"
        echo ""
else
        echo "test $task failed to execute"
fi


done

done

wait

#export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
#export LAUNCHER_RMI=SLURM
#export LAUNCHER_JOB_FILE=/home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/simpleArray.sh
 
#$LAUNCHER_DIR/paramrun
