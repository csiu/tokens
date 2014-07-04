# Takes bam file -> extract fastq with biobambam -> runs alignment to ${BUILD}
# script should be ran in directory above "original_bam"
# Author: csiu
# Created: Thur July 3, 2014

# Input:
# 1. bam files located in directory "original_bam/"
ORIGINAL_BAMDIR=original_bam
# 2. "samples.txt" - list of bam files in "original_bam/" without file extension
SAMPLE=$1
SAMPLE=${SAMPLE:-samples.txt}

# Input directory structure:
#   |-- original_bam/
#   |   |-- some-bamfile.bam
#   |   |-- another-bamfile.bam
#   |-- samples.txt
#
# Content of "samples.txt":
# some-bamfile
# another-bamfile

# softwares
BIOBAMBAM_BAMTOFASTQ= [path to biobambam software; i.e. biobambam-0.0.92/bin/bamtofastq]
BWA=      [path to bwa;              i.e. bwa-0.7.4/bwa]
SAMTOOLS= [path to samtools;         i.e. samtools-0.1.17/samtools]
JAVA=     [path to java;             i.e. jre1.7.0_03/bin/java]
PICARD=   [path to picard directory; i.e. picard-tools-1.71]

PICARD_REGEX='"[a-zA-Z0-9]+_[0-9]+:[0-9]+:([0-9]+):([0-9]+):([0-9]+).*"'

# reference to align to
REFERENCE= [path to reference.fa] 
BUILD=hg19 #example

NOW=$(date +"%F.%H-%M-%S")
UMASK=002

LOGDIR=log/log.${NOW}
FASTQDIR=fastq
SCRIPTSDIR=scripts
OUTDIR=realign
DUP_TMPDIR=$PWD/${OUTDIR}

# helper functions ============================================================
create_job_script_extractfastq_biobambam () {
QSUB_HEADER="""#!/bin/bash
#
#$ -q all.q
#$ -N ${ID}
#$ -V
#$ -wd ${WD}
#$ -now n
#$ -notify
#$ -j y
#$ -o ${LOGDIR}/${ID}.o
#$ -S /bin/bash
#$ -b n
#$ -pe ncpus 3
#$ -l mem_token=500M,h_vmem=1G
"""

JOB=$(echo -e """$QSUB_HEADER
echo "[\`date +%F.%H-%M-%S\`] Start ${ID}"
${CMD}
echo "[\`date +%F.%H-%M-%S\`] ${ID} Complete!"
""")

echo "$JOB" > ${WD}/${SCRIPTSDIR}/${ID}.${NOW}.sh
}

create_job_script () {
QSUB_HEADER="""#!/bin/bash
#
#$ -wd ${WD}
#$ -j y
#$ -o ${LOGDIR}/${ID}.o
#$ -S /bin/bash
#$ -l mem_free=3.5G,h_vmem=5G
#$ -N ${ID}
#$ -hold_jid ${HOLD_JID}
"""

JOB=$(echo -e """$QSUB_HEADER
echo "[\`date +%F.%H-%M-%S\`] Start ${ID}"
${CMD}
echo "[\`date +%F.%H-%M-%S\`] ${ID} Complete!"
""")

echo "$JOB" > ${WD}/${SCRIPTSDIR}/${ID}.${NOW}.sh
}

add_script_to_qsub () {
    SCRIPTS_TO_QSUB="$SCRIPTS_TO_QSUB $PWD/${SCRIPTSDIR}/${ID}.${NOW}.sh"
}
#==============================================================================

mkdir -v -p -m 770 ${LOGDIR} ${FASTQDIR} ${SCRIPTSDIR} ${OUTDIR}
umask ${UMASK}

cat ${SAMPLE} | while read s ; do
    WD=$PWD
    SCRIPTS_TO_QSUB=""

    ## Job01: Extract fastq
    BAM=${ORIGINAL_BAMDIR}/${s}.bam
    FQ1=${FASTQDIR}/${s}.1.fastq
    FQ2=${FASTQDIR}/${s}.2.fastq

    ID=j01fastq${s}
    CMD="time ${BIOBAMBAM_BAMTOFASTQ} F=${FQ1} F2=${FQ2} inputformat=bam filename=${BAM} exclude=QCFAIL"
    create_job_script_extractfastq_biobambam
    add_script_to_qsub

    ## Job02A, Job02B: gapped/ungapped alignment
    FAI1=${FQ1/%fastq/fai}
    FAI2=${FQ2/%fastq/fai}

    HOLD_JID=j01fastq${s}

    ID=j02Aaln${s}
    CMD="${BWA} aln ${REFERENCE} ${FQ1} > ${FAI1}"
    create_job_script
    add_script_to_qsub

    ID=j02Baln${s}
    CMD="${BWA} aln ${REFERENCE} ${FQ2} > ${FAI2}"
    create_job_script
    add_script_to_qsub

    ## Job03: generate alignment (paired ended)
    SAM=${OUTDIR}/${s}_${BUILD}.sam

    ID=j03sampe${s}
    HOLD_JID=j02Aaln${s},j02Baln${s}
    CMD="${BWA} sampe ${REFERENCE} ${FAI1} ${FAI2} ${FQ1} ${FQ2} > ${SAM}"
    create_job_script
    add_script_to_qsub

    ## Job04: Removing tmp fastq files
    ID=j04rmfastq${s}
    HOLD_JID=j03sampe${s}
    CMD="rm -v ${FAI1} ${FAI2}"
    create_job_script
    add_script_to_qsub

    ## Job05: Creating bam file
    UNSRT_BAM=${OUTDIR}/${s}_${BUILD}.unsrt.bam

    ID=j05createBam${s}
    HOLD_JID=j03sampe${s}
    CMD="${SAMTOOLS} view -S ${SAM} -b > ${UNSRT_BAM}"
    create_job_script
    add_script_to_qsub

    ## Job06: Sorting bam file
    SRT_BAM_PREFIX=${OUTDIR}/${s}_${BUILD}.srt
    SRT_BAM=${SRT_BAM_PREFIX}.bam

    ID=j06sort${s}
    HOLD_JID=j05createBam${s}
    CMD="${SAMTOOLS} sort ${UNSRT_BAM} ${SRT_BAM_PREFIX}"
    create_job_script
    add_script_to_qsub

    ## Job07: Marking duplicates
    DUPSFLAG_BAM=${OUTDIR}/${s}_${BUILD}_dupsFlagged.bam
    PICARD_METRICS_FILE=${OUTDIR}/${s}_${BUILD}.paired.metrics.txt

    ID=j07dups${s}
    HOLD_JID=j06sort${s}
    CMD="${JAVA} -Xmx3062M -jar ${PICARD}/MarkDuplicates.jar INPUT=${SRT_BAM} OUTPUT=${DUPSFLAG_BAM} METRICS_FILE=${PICARD_METRICS_FILE} ASSUME_SORTED=true READ_NAME_REGEX=${PICARD_REGEX} OPTICAL_DUPLICATE_PIXEL_DISTANCE=16 VALIDATION_STRINGENCY=LENIENT TMP_DIR=${DUP_TMPDIR}"
    create_job_script
    add_script_to_qsub

    ## Job08: Removing tmp bam files
    ID=j08rmTmpBam${s}
    HOLD_JID=j07dups${s}
    CMD="rm -v ${SAM} ${UNSRT_BAM} ${SRT_BAM}"
    create_job_script
    add_script_to_qsub

    ## Job09: Indexing bam
    ID=j09index${s}
    HOLD_JID=j07dups${s}
    CMD="${SAMTOOLS} index ${DUPSFLAG_BAM}"
    create_job_script
    add_script_to_qsub

    ## Job10: Flagstat
    FLAGSTAT_BAM=${DUPSFLAG_BAM}.flagstat

    ID=j10flagstat${s}
    HOLD_JID=j07dups${s}
    CMD="${SAMTOOLS} flagstat ${DUPSFLAG_BAM} > ${FLAGSTAT_BAM}"
    create_job_script
    add_script_to_qsub


    for script in $SCRIPTS_TO_QSUB ; do
	echo "qsub $script"
    done

done > MASTERrun.${BUILD}_realignment.sh.${NOW}