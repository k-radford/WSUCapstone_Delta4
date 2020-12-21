#!/bin/sh
#SBATCH -J runChem1        # Job name
#SBATCH -o runChem1.%jo    # Name of stdout output file
#SBATCH -e runChem1.%je    # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 03:00:00        # Run time (hh:mm:ss)
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)

module load gnuparallel/git20180620

DIR="test1.1"

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/$DIR/

ARGS="wat1.xyz"

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

