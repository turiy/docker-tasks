#options=--no-cache
start=`date +%s`
docker build -t test_mysql .
end=`date +%s`

runtime=$((end-start))
#echo "Time is $runtime seconds"
docker images
