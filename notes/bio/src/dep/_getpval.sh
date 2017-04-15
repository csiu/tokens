infile=$1
dbFile=$2
outfile=$3


#infile="diseased.H3K27ac.multiinter.bed.test" ## argument?
#outfile=${infile}.pval ## argument?
#dbFile=files/$(basename ${infile} | cut -d'.' -f1,2).txt ## argument?

n_files=$(cat ${dbFile} | wc -l)

## Get data
i=0
cat $dbFile | while read finderResult; do
    ((i++))
    bedtools intersect -a ${infile} -b ${finderResult} -wao | \
	awk -F'\t' '$12=="Infinity"{$12 = 0}1' OFS="\t" > ${infile}.${i}.tmp
    bedtools groupby -i ${infile}.${i}.tmp -g 1,2,3 -c 12 -o max | \
	awk '{print $NF}' > ${infile}.${i}
    rm ${infile}.${i}.tmp
done

## Combine
paste -d"\t" ${infile} $(eval `echo echo ${infile}.{1..$n_files}`) > ${outfile}

## Rm tmp files
rm $(eval `echo echo ${infile}.{1..$n_files}`)
