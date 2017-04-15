INFILE=$1
OUTDIR=$2

DIROFINTEREST=/projects/csiu_prj/data/chip-seq/finder/CEMT_4*

[[ -d $OUTDIR ]] || mkdir $OUTDIR
cat $INFILE | while IFS="." read condition mark ; do
    [[ $condition == "normal" ]] && SAMPLES="CEMT_4[024]" ;
    [[ $condition == "diseased" ]] && SAMPLES="CEMT_4[135]" ;
    find $DIROFINTEREST ! -type d -path "*$mark*" -name '*gz' | grep $SAMPLES | sort > $OUTDIR/${condition}.${mark}.txt ;
done
