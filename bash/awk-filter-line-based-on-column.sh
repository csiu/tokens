# For tab-delimited file
# Look for column matching this regex: "N_.*_count"
# Filter lines: if value.of.select.column (i.e. ncount) == 0, then keep line

f=FILE.txt 
out=$f.filtNcount

HEADER=$(head -1 $f)
COL=`echo "$HEADER" | awk -F'\t' '{for (i=1;i<=NF;i++) { if ($i~/N_.*_count/) {print i} }}'`
sed '1d' $f | awk -F'\t' -v header="$HEADER" -v ncount=$COL 'BEGIN {print header} {if ($ncount == 0) {print $0}}' > $out
