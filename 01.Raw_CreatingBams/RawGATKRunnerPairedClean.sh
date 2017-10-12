#! /bin/sh
Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar"
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
Referance="Apple_genome_v1.1"
CleanDirectory="/data/pabster212/Apple_reseq/raw"



#bwa index ${Referance}.fa
#samtools faidx ${Referance}.fa
#
#
#java -jar ${Picard}  CreateSequenceDictionary \
#    REFERENCE=${Referance}.fa \
#    OUTPUT=${Referance}.dict


#$ReadGroupForm="@RG\tID:XX\tSM:X1\tPL:illumina\tLB:lib\tPU:XXX"
#Apple MismatchScores

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


#for key in ${!arr[@]}; do
#        echo ${key} ${arr[${key}]}
#    done


for i in `cat $1`; do RemveEndind=${i%_R*}; \
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

    echo "EXECUTING BWA ${BasefileName}" ; \

    bwa mem -B ${mismatch} -t 30 ${Referance}.fa ${CleanDirectory}/${BasefileName}_R1.ndupB.paired.fq.gz \
    ${CleanDirectory}/${BasefileName}_R2.ndupB.paired.fq.gz > ${BasefileName}.aligned_reads.sam ; \

    echo "MARKING DUPLICATES OF ${BasefileName}"; \

    java -jar ${Picard} SortSam \
    INPUT=${BasefileName}.aligned_reads.sam \
    OUTPUT=${BasefileName}.sorted_reads.bam \
    SORT_ORDER=coordinate; 


    java -jar ${Picard} MarkDuplicates \
    INPUT=${BasefileName}.sorted_reads.bam \
    OUTPUT=${BasefileName}.dedup_reads.bam \
    METRICS_FILE=${BasefileName}.metrics.txt ;


    rm ${BasefileName}.aligned_reads.sam ;
    rm ${BasefileName}.sorted_reads.bam ;

done 



#java -jar /home/jiaochen/software/picard-tools-1.141/picard.jar BuildBamIndex
#INPUT=X

#bwa mem -p ${Referance}.fa ${BasefileName}_R1.fq.gz
#${BasefileName}_R2.fq.gz > \
#${Reads}.aligned_reads.sam
#
#
#
#java -jar ${Picard} MarkDuplicates \
#    INPUT=${Reads}.aligned_reads.sam \
#    OUTPUT=${Reads}.dedup_reads.bam \
#    SO=coordinate
#
#
#java -jar ${Gatk} \
#    -T RealignerTargetCreator \
#    -R ${Referance}.fa \
#    -I ${Reads}.dedup_reads.bam \
#    -L 20 \
#    -o ${Reads}.target_interval.list
#
#java -jar ${Gatk} \
#    -T IndelRealigner \
#    -R ${Referance}.fa \
#    -I ${Reads}.dedup_reads.bam \
#    -targetIntervals ${Reads}.target_interval.list \
#    -o ${reads}.realigned.bam
#
#    
#    
#java -jar ${Gatk} \
#    -T BaseRecalibrator \
#    -R ${Referance}.fa \
#    -I ${Reads}.dedup_reads.bam \
#    -L 20 \
#    -knownSites ${Reads}.vcf
#    -knownSites
#    -o ${Reads}.pre_recal_data.grp
#    -plots ${Reads}.before_recall.pdf
#
#java -jar ${Gatk} \
#    -T BaseRecalibrator \
#    -R ${Referance}.fa \
#    -I ${Reads}.dedup_reads.bam \
#    -L 20 \
#    -BQSR ${Reads}.racal_data.grp
#    -o ${Reads}.post_recal_data.grp
#    -plots ${Reads}.after_recall.pdf
#
#java -jar ${Gatk} \
#    -T PrintReads \
#    -R ${Referance}.fa \
#    -I ${Reads}.dedup_reads.bam \
#    -L 20 \
#    -BQSR ${Reads}.recal_data.grp
#    -o ${Reads}.recal_reads.bam
#
#
#java -jar ${Gatk} \
#    -T ReduceReads \
#    -R ${Referance}.fa \
#    -I ${Reads}.recal_reads.bam
#    -L 20
#    -o ${Reads}.reduced_reads.bam
#


