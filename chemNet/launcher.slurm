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
#SBATCH -J launcher 
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p normal
#SBATCH -o launcher.%jo
#SBATCH -e launcher.%je
#SBATCH -t 00:15:00
#          <------ Account String ----->
#SBATCH -A TG-CHE190077
#------------------------------------------------------

module load launcher

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=/home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/simpleArray.sh
 
$LAUNCHER_DIR/paramrun

