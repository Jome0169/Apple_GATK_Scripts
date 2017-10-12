#! /bin/sh

Picard="/data/pabster212/Programs/picard/build/libs/picard.jar" # Remember to
Samtools="samtools"
Gatk="/data/pabster212/Programs/GenomeAnalysisTK-3.8-0-ge9d806836/GenomeAnalysisTK.jar"
Referance="spinach_genome_v1"

set -euxo pipefail



for i in `cat ${1}` ; do RemveEndind=${i%.sorted_reads.bam*}; \
    BasefileName=${RemveEndind##*/} ;\
    TrueBase=${BasefileName%_PE*}; FirstLetter="$(echo $TrueBase | head -c 1)";
    echo $TrueBase ; 


	echo ""java -jar ${Picard} MarkDuplicates \
    INPUT=${BasefileName}.sorted_reads.bam \
    OUTPUT=${BasefileName}.dedup_reads.bam \
    METRICS_FILE=${BasefileName}.metrics.txt ;

    java -jar ${Picard} MarkDuplicates \
	MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
    INPUT=${BasefileName}.sorted_reads.bam \
    OUTPUT=${BasefileName}.dedup_reads.bam \
    METRICS_FILE=${BasefileName}.metrics.txt ;

done 
