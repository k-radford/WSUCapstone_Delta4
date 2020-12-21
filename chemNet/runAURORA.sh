#!/bin/sh
#SBATCH -J myAurora          # Job name
#SBATCH -o myAurora.%jo      # Name of stdout output file
#SBATCH -e myAurora.%je      # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=kaitlin.radford@wsu.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)


module load gnuparallel/git20180620

for task in 1 2 3 4
do

case $task in
	1)
		ARGS="water1.xyz" 
		;;
	2)ARGS="water1.xyz solB1.xyz" ;;
        3)ARGS="water1.xyz solB1.xyz solC1.xyz" ;;
        4)ARGS="water1.xyz solC1.xyz solB1.xyz" ;;
esac

echo "running test$task"
cd /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test$task/

/home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test$task $ARGS
lab=$?


done
