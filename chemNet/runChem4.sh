#!/bin/sh
#SBATCH -J runChem4        # Job name
#SBATCH -o runChem4.%jo    # Name of stdout output file
#SBATCH -e runChem4.%je    # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)

echo "testing test4"

module load gnuparallel/git20180620

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test4/

time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test4 wat1.xyz solC1.xyz solB1.xyz
lab=$?

if test $lab -eq 0; then
        echo "test4 passed"
        echo ""
else
        echo "test4 failed"
fi

