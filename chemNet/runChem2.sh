#!/bin/sh
#SBATCH -J runChem2        # Job name
#SBATCH -o runChem2.o%j      # Name of stdout output file
#SBATCH -e runChem2.e%j      # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)

echo "testing test2"

module load gnuparallel/git20180620

cd /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test2/

/home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test2 wat2.xyz solB1.xyz
lab=$?

if test $lab -eq 0; then
        echo "test2 passed"
        echo ""
else
        echo "test2 failed"
fi

