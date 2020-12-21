echo "-------------------------- TEST SCRIPT -------------------------------"
echo " "
echo "Inputs: $@"
INPUTS=$@

#grab job execution strings
IFS=',' read -r -a JOB <<< $2

module load launcher

#run tests
for j in "${!JOB[@]}"
do
echo "Submitting Job $j: ${JOB[j]}"
#time /home1/07020/dtuser/work/capstone/Kate/All/ChemNetworks-2-2/ChemNetworks-2.2.exe ${JOB[j]} &
PIDS+=($!)
((j+=1))
done

exit
