nvidia-smi pmon -d 2 > tmp.txt & #process monitoring every 2 seconds
pmonpid=$! #pid of nvidia-smi
python $1 & # execute python script given in cli
pypid=$!
echo $pypid
wait "$pypid"
kill "$pmonpid"
#grep "$pypid" tmp.txt | awk '{s+=$4}END{print "mean gpu usage:",s/NR, "%"}' # compute the mean gpu usage -all process
grep "$pypid" tmp.txt | awk '$4>50 {s+=$4; count++}END{print "mean gpu usage:",s/count, "%"}' # compute the mean gpu usage, cuts some values at the beginning and end
rm tmp.txt
