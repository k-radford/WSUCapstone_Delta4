#!/bin/sh
#SBATCH -J runChem        # Job name
#SBATCH -o runChem.%jo    # Name of stdout output file
#SBATCH -e runChem.%je    # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 48:00:00        # Run time (hh:mm:ss)
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)

module load gnuparallel/git20180620

TESTNUM="1"
WATERNUM="4"
DIR=${SLURM_JOBID}/test$TESTNUM.$WATERNUM

mkdir /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/${SLURM_JOBID}

mkdir /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/$DIR

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test$TESTNUM

cp Input-test$TESTNUM /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/$DIR

case $TESTNUM in
	1)ARGS="wat$WATERNUM.xyz" ;;
	2)ARGS="wat$WATERNUM.xyz solB1.xyz" ;;
	3)ARGS="wat$WATERNUM.xyz solB1.xyz solC1.xyz" ;;
	4)ARGS="wat$WATERNUM.xyz solC1.xyz solB1.xyz" ;;

esac

cp $ARGS /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/$DIR
cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/$DIR

echo "testing test1 for $ARGS from $DIR"

time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test1 $ARGS
lab=$?

echo "here"

if test $lab -eq 0; then
        echo "test1 passed with $ARGS"
        echo ""
else
        echo "test1 failed with $ARGS"
fi

echo "end of script"

exit
