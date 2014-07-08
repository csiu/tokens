
# Remove Read Group info/Reheader bam file
# Author: csiu
# Created: Thur July 8, 2014

# Input:
# 1. bam files located in directory "original_bam/"
ORIGINAL_BAMDIR=original_bam
# 2. "samples.txt" - list of bam files in "original_bam/" without file extension
SAMPLE=$1
SAMPLE=${SAMPLE:-samples.txt}

# Directory structure:
#   |-- original_bam/
#   |   |-- some-bamfile.bam
#   |   |-- another-bamfile.bam
#   |-- samples.txt
#
# Content of "samples.txt":
# some-bamfile
# another-bamfile

# softwares
SAMTOOLS=[path to samtools; i.e. samtools-0.1.17/samtools]

NOW=$(date +"%F.%H-%M-%S")
UMASK=002

LOGDIR=log/log.${NOW}
SCRIPTSDIR=scripts
OUTDIR=reheader

# helper functions ============================================================
create_job_script () {
if [[ "${ACTIVATE_HOLDJID}" == "true" ]] ; then 
QSUB_HEADER="""#!/bin/bash
#
#$ -wd ${WD}
#$ -j y
#$ -o ${LOGDIR}/${ID}.o
#$ -S /bin/bash
#$ -l mem_free=80M,h_vmem=200M
#$ -N ${ID}
#$ -hold_jid ${HOLD_JID}
"""
else
QSUB_HEADER="""#!/bin/bash
#
#$ -wd ${WD}
#$ -j y
#$ -o ${LOGDIR}/${ID}.o
#$ -S /bin/bash
#$ -l mem_free=80M,h_vmem=200M
#$ -N ${ID}
"""
fi

JOB=$(echo -e """$QSUB_HEADER
echo "[\`date +%F.%H-%M-%S\`] Start ${ID}"
${CMD}
echo "[\`date +%F.%H-%M-%S\`] ${ID} Complete!"
""")

echo "$JOB" > $PWD/${SCRIPTSDIR}/${ID}.${NOW}.sh 
}
add_script_to_qsub () {
    SCRIPTS_TO_QSUB="$SCRIPTS_TO_QSUB $PWD/${SCRIPTSDIR}/${ID}.${NOW}.sh"
}
#==============================================================================

mkdir -v -p -m 770 ${LOGDIR} ${SCRIPTSDIR} ${OUTDIR} 
umask ${UMASK}

cat ${SAMPLE} | while read s ; do 
    WD=$PWD
    SCRIPTS_TO_QSUB=""

    ACTIVATE_HOLDJID=false

    ## Job01: Save header to file
    BAM=${ORIGINAL_BAMDIR}/${s}.bam
    BAMHEADER=${OUTDIR}/${s}.header

    ID=j01saveHeader${s}
    CMD="${SAMTOOLS} view -H ${BAM} > ${BAMHEADER}"
    create_job_script
    add_script_to_qsub
    
    ACTIVATE_HOLDJID=true

    ## Job02: Delete read group info from header
    ID=j02rmRG${s}
    HOLD_JID=j01saveHeader${s}
    CMD="sed -i '/^@RG\\\t/d' ${BAMHEADER}"
    create_job_script
    add_script_to_qsub

    ## Job03: Reheader bam file
    NEW_BAM=${OUTDIR}/${s}_reheader.bam
    
    ID=j03reheader${s}
    HOLD_JID=j02rmRG${s}
    CMD="${SAMTOOLS} reheader ${BAMHEADER} ${BAM} > ${NEW_BAM}"
    create_job_script
    add_script_to_qsub


    for script in $SCRIPTS_TO_QSUB ; do
	echo "qsub $script"
    done

done > MASTERrun.hg19_realignment.sh.${NOW}
