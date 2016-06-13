convert_sort_sam () {
    n=${1%.*}
    samtools view -b $1 | samtools sort -O bam -T $TMPDIR/$n - > $n.sorted.bam
    samtools index $n.sorted.bam
}

removelink() {
  [ -L "$1" ] && /bin/cp --remove-destination "$(readlink "$1")" "$1"
}

n50() {
    awk '!(NR % 2) {print length($0)}' $1 | sort -n | awk '{len[i++]=$1;sum+=$1} END {for (j=0;j<i+1;j++) {csum+=len[j]; if (csum>sum/2) {print len[j];break}}}'
}
