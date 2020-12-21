#!/bin/bash
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
#SBATCH -J testDeltaPersist
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p normal
#SBATCH -o testDeltaPersist.%jo
#SBATCH -e testDeltaPersist.%je
#SBATCH -t 05:00:00
#SBATCH -A TG-CHE190077

#------------------------------------------------------

cd /home1/07020/dtuser/work/capstone/Kate/All/thrust2/software/deltapersistence

echo "Running test 1: produce the barcodes for pentane"
python3 persistence_script.py --carbons 5 --disp &
PIDS+=($!)

echo "Running test 2: generate the bars for pentane with non-bonded interactions"
python3 persistence_script.py -f tests/cube.txt -t cube --bars &
PIDS+=($!)

echo "Running test 3: generate the persistence diagram for hexane from the energy landscape $
python3 persistence_script.py -f tests/mesh.npy -t mesh --diagram &
PIDS+=($!)

echo "Running test 4: generate the barcodes for the sublevelsets of the function f(x,y) = - $
python3 persistence_script.py -f tests/coords.dat -e tests/energy.dat -t sample --bars &
PIDS+=($!)

j=0
for pid in ${PIDS[@]}; do
        echo "waiting for test $j: pid = ${pid}"
        wait ${pid}
        STATUS+=($?)
        status=$?
        if test $status -eq 0; then
                echo "Job $j completed"
                PASSED+=($j)
        else
                echo "Job $j failed to execute"
                FAILED+=($j)
        fi
        ((j+=1))

done

echo " "
echo "PASSED    FAILED"
for (( i = 0; i <= $1; i++ )); do
        echo "${PASSED[i]}      ${FAILED[i]}"
done

exit
