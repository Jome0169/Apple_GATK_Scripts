#! /bin/sh
set -euxo pipefail


Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"

java -jar ${Picard} MergeVcfs \
I=Final.filtered.snp.vcf \
I=Apple.Chr00.vcf.indel.vcf \
I=Apple.Chr01.vcf.indel.vcf \
I=Apple.Chr02.vcf.indel.vcf \
I=Apple.Chr10.vcf.indel.vcf \
I=Apple.Chr11.vcf.indel.vcf \
I=Apple.Chr03.vcf.indel.vcf \
I=Apple.Chr12.vcf.indel.vcf \
I=Apple.Chr04.vcf.indel.vcf \
I=Apple.Chr13.vcf.indel.vcf \
I=Apple.Chr14.vcf.indel.vcf \
I=Apple.Chr05.vcf.indel.vcf \
I=Apple.Chr06.vcf.indel.vcf \
I=Apple.Chr15.vcf.indel.vcf \
I=Apple.Chr07.vcf.indel.vcf \
I=Apple.Chr16.vcf.indel.vcf \
I=Apple.Chr08.vcf.indel.vcf \
I=Apple.Chr17.vcf.indel.vcf \
I=Apple.Chr09.vcf.indel.vcf \
OUTPUT=Comnbined.Snp.Indel.vcf \
