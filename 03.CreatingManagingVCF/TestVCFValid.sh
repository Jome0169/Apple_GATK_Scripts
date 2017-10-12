 #! /bin/sh
set -euxo pipefail


Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"



java -jar ${Gatk} \
   -T ValidateVariants \
   -R ${Referance}.fa\
   -V ${1}\
   --validationTypeToExclude ALL
