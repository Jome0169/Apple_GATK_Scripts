#! /bin/sh

Picard="/data/pabster212/Programs/picard/build/libs/picard.jar" # Remember to
Samtools="samtools"
Gatk="/data/pabster212/Programs/GenomeAnalysisTK-3.8-0-ge9d806836/GenomeAnalysisTK.jar"
Referance="spinach_genome_v1"

set -euxo pipefail

#This above line really helps with errors and pipefails - but it also makes
#arrays resond in one of the strangest ways i have experianced. Weird Stuff -
#Fo show


#bwa index ${Referance}.fa
#samtools faidx ${Referance}.fa
#
#
#java -jar ${Picard}  CreateSequenceDictionary \
#    REFERENCE=${Referance}.fa \
#    OUTPUT=${Referance}.dict



for i in `cat ${1}` ; do RemveEndind=${i%_R*}; \
    BasefileName=${RemveEndind##*/} ;\
    TrueBase=${BasefileName%_PE*}; FirstLetter="$(echo $TrueBase | head -c 1)";
    echo $TrueBase ; 

    #echo $BasefileName

    #echo "EXECUTING BWA ${BasefileName}" ; \
    #bwa mem -B 5 -t 30 ${Referance}.fa ${BasefileName}_R1.ndupB.paired.fq.gz \
    #${BasefileName}_R2.ndupB.paired.fq.gz > ${BasefileName}.aligned_reads.sam ; \

    #echo "MARKING DUPLICATES OF ${BasefileName}"; \

    #java -jar ${Picard} SortSam \
    #INPUT=${BasefileName}.aligned_reads.sam \
    #OUTPUT=${BasefileName}.sorted_reads.bam \
    #SORT_ORDER=coordinate; 


	echo ""java -jar ${Picard} MarkDuplicates \
    INPUT=${BasefileName}.sorted_reads.bam \
    OUTPUT=${BasefileName}.dedup_reads.bam \
    METRICS_FILE=${BasefileName}.metrics.txt ;

    java -jar ${Picard} MarkDuplicates \
	MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
    INPUT=${BasefileName}.sorted_reads.bam \
    OUTPUT=${BasefileName}.dedup_reads.bam \
    METRICS_FILE=${BasefileName}.metrics.txt ;


    #rm ${BasefileName}.aligned_reads.sam ;
    #rm ${BasefileName}.sorted_reads.bam;
    ##rm ${BasefileName}_R1.fq.gz;
    ##rm ${BasefileName}_R2.fq.gz;


done 
