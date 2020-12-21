#!/bin/sh
#SBATCH -J myjobAll        # Job name
#SBATCH -o myjobAll.o%j    # Name of stdout output file
#SBATCH -e myjobAll.e%j    # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=kaitlin.radford@wsu.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)


module load gnuparallel/git20180620

echo "testing test1"
cd /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test1/
ibrun /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test1 water1.xyz
lab1=$?
if test $lab1 -eq 0; then
        echo "test1 passed"
        echo ""
else
	echo "test1 failed"
fi

echo "testing test2"
cd /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test2/
ibrun /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test2 water1.xyz solB1.xyz
lab2=$?
if test $lab2 -eq 0; then
        echo "test2 passed"
        echo ""
else
	echo "test2 failed"
fi

echo "testing test3"
cd /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test3/
ibrun /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test3 water1.xyz solB1.xyz solC1.xyz
lab3=$?
if test $lab3 -eq 0; then
        echo "test3 passed"
        echo ""
else
	echo "test3 failed"
fi

echo "testing test4"
cd /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/test-jobs/test4/
ibrun /home1/07020/dtuser/scratch/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe Input-test4 water1.xyz solC1.xyz solB1.xyz
lab4=$?
if test $lab4 -eq 0; then
        echo "test4 passed"
        echo ""
else
        echo "tests failed"
fi
