#We Have to get picard metrics for all these fucking things

#! /bin/sh
Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"
FinalLocation="/data/pabster212/01.Malus_Snp/06.BAMFILEMETRICS/RAW/"




set -euxo pipefail


#java -jar ${Picard} MarkDuplicates \
#MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
#INPUT=${BasefileName}.sorted_reads.bam \
#OUTPUT=${BasefileName}.dedup_reads.bam \
#METRICS_FILE=${BasefileName}.metrics.txt ;

for i in `ls *dedup_reads.bam` ; do BasefileName=${i%.dedup_reads.bam}; 

java -jar ${Picard} CollectAlignmentSummaryMetrics \
REFERENCE_SEQUENCE=${Referance}.fa \
INPUT=${BasefileName}.dedup_reads.bam \
OUTPUT=${BasefileName}.aln.metrics.txt ;

mv ${BasefileName}.aln.metrics.txt ${FinalLocation};

done 
