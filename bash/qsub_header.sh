JOBNAME="somejob"
LOGDIR="logs"
NOW=$(date +"%F.%H-%M-%S")

QSUB_HEADER="""#!/bin/bash
#
#$ -wd ${PWD}
#$ -N ${JOBNAME}
#$ -o ${LOGDIR}/${JOBNAME}.o.${NOW}
#$ -e ${LOGDIR}/${JOBNAME}.e.${NOW}
#$ -j y
#$ -S /bin/bash
#$ -l mem_token=500M,h_vmem=1G
#$ -q all.q
#$ -now n
#$ -b n 
#$ -pe ncpus 3 
#$ -notify
#$ -V 
"""

INFO="""
-wd working_dir
execute jobs from this directory

-N name
name the job

-o path
standard output stream

-e path
starndard error stream

-j y|n
join standard error to standard output stream?

-S path
specifies the interpreting shell

-l resource=value,...
launch job in queue meeting given resource request 

-q wc_queue_list
specify queue to use

-now y|n
start job immediately or exit 1

-b y|n
whether to treat as binary or script

-pe parallel_environment n[-[m]]|[-]m
???

-notify
send warnings to a running job prior to sending the signals themselves

-V
Specifies that all environment variables active within the qsub utility 
be exported to the context of the job
"""

echo """qsub header example:
`printf "%0.s=" {1..50}`
${QSUB_HEADER}
`printf "%0.s=" {1..50}`
Details:
${INFO}
"""
