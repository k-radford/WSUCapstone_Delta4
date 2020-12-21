#!/bin/sh
#SBATCH -J myAurora2          # Job name
#SBATCH -o myAurora2.o%j      # Name of stdout output file
#SBATCH -e myAurora2.e%j      # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=kaitlin.radford@wsu.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A TG-CHE190077    # Allocation name (req'd if you have more than 1)


module load gnuparallel/git20180620

for task in {1..4}
do
{

cp ChemNetworks-2.2.exe ChemNetworks-2.2.${task}.exe
cp waterwater.input waterwater${task}.input
 
./ChemNetworks-2.2.${task}.exe waterwater${task}.input wat${task}.xyz Solute.${task}.xyz
 
 
rm ChemNetworks-2.2.${task}.exe
rm waterwater${task}.input

}
done
