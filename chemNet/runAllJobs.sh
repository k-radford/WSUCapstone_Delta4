#!/bin/sh
#SBATCH -J jobAll2       # Job name
#SBATCH -o jobAll2.o%j   # Name of stdout output file
#SBATCH -e jobAll2.e%j   # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 4               # Total # of nodes (must be 1 for serial)
#SBATCH -n 32              # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=kaitlin.radford@wsu.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)


bash /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/runChem1.sh

bash /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/runChem2.sh

bash /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/runChem3.sh

bash /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/runChem4.sh
