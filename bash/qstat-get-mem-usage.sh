# Monitor memory usage of qsub job
JID=3250847; SLEEP=30 
while [[ `qstat -j ${JID}` ]] ; do echo "[ `date +%F.%H-%M-%S` ] `qstat -j ${JID} | grep usa`" >> ${JID}.mem ; sleep ${SLEEP} ; done
