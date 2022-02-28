lwlimit=$2
uplimit=$3
new_file="fix_"$1
echo "name of the original file" $1
echo "Defined lower limit " $lwlimit
echo "Defined  upper limit" $uplimit
echo "New file name "       $new_file

natom=$(sed -n '7,7p;8q' $1 |  awk '{natom=0; for (i = 1;i<=NF; i++) {natom+=$i} print natom ; Tatom=natom }')
echo "Total number of atoms incountered" $natom
sline=8
#lline=`echo $natom + $sline |bc`
head -n $sline $1 > $new_file
fix=" F F F"
flx=" T T T"
# tail -n $natom $1 >  temp_file_check
# sed  -i -e "s/\r//g" temp_file_check  # this remove special character ^M
# awk '{if ($3 > '$lwlimit' && $3 < '$uplimit') print $1, $2, $3, " F F F" }' temp_file_check >> new_file
tail -n $natom $1 | sed -e "s/\r//g" | \
awk '{if ($3 > '$lwlimit' && $3 < '$uplimit') \
     print $1, $2, $3, " F F F"; \
else print $1, $2, $2, " T T T"} ' >> $new_file


