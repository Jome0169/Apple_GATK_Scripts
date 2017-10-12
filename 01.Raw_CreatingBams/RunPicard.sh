#! /bin/sh

Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
Referance="Apple_genome_v1.1"
CleanDirectory="/home/pabster212/01.Malus_Snp/00.src/clean/paired-end"

declare -A arr
arr+=(
["A24"]=9
["A25"]=7
["A26"]=9
["A27"]=9
["A29"]=9
["A30"]=9
["A31"]=6
["A32"]=6
["A33"]=7
["A34"]=5
["A35"]=7
["A50"]=6
["A51"]=6
["A52"]=6
["A53"]=5
["A54"]=5
["A55"]=5
["A56"]=5
["A57"]=6
["A58"]=5
["A59"]=7
["C100"]=5
["C102"]=5
["C105"]=5
["C108"]=5
["C113"]=5
["C123"]=5
["C99"]=6 )


for i in "${CleanDirectory}"/*_R1.fq.gz ; do RemveEndind=${i%_R*}; \
    BasefileName=${RemveEndind##*/} ;\
    TrueBase=${BasefileName%_PE*}; FirstLetter="$(echo $TrueBase | head -c 1)";

   if [ ${arr[${TrueBase}]} ]
    then
        #set mimatch to array above
        mismatch=${arr[${TrueBase}]}
    elif [ ${FirstLetter} == "M"  ]
    then
        #MISMATCH OF 9
        mismatch=9
    else
        #MISMATCH of 9
        mismatch=4
    fi; 
    echo $mismatch

    echo "EXECUTING BWA ${BasefileName}" ; \
    bwa mem -B ${mismatch} -t 30 ${Referance}.fa ${CleanDirectory}/${BasefileName}_R1.fq.gz \
    ${CleanDirectory}/${BasefileName}_R2.fq.gz > ${BasefileName}.aligned_reads.sam ; \

    echo "MARKING DUPLICATES OF ${BasefileName}"; \

    java -jar ${Picard} SortSam \
    INPUT=${BasefileName}.aligned_reads.sam \
    OUTPUT=${BasefileName}.sorted_reads.bam \
    SORT_ORDER=coordinate; 


#    java -jar ${Picard} MarkDuplicates \
#    INPUT=${BasefileName}.sorted_reads.bam \
#    OUTPUT=${BasefileName}.dedup_reads.bam \
#    METRICS_FILE=${BasefileName}.metrics.txt ;
#
#
    rm ${BasefileName}.aligned_reads.sam ;
#    rm ${BasefileName}.dedup_reads.bam ;

done 
#












