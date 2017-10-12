#! /bin/sh
set -euxo pipefail


Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"


# java -Xmx400g  -cp ${Gatk} org.broadinstitute.gatk.tools.CatVariants \
#    -log X \
#    -R ${Referance}.fa \
#    -V Apple.Chr00.vcf \
#    -V Apple.Chr01.vcf \
#    -V Apple.Chr02.vcf \
#    -V Apple.Chr03.vcf \
#    -V Apple.Chr04.vcf \
#    -V Apple.Chr05.vcf \
#    -V Apple.Chr06.vcf \
#    -V Apple.Chr07.vcf \
#    -V Apple.Chr08.vcf \
#    -V Apple.Chr09.vcf \
#    -V Apple.Chr10.vcf \
#    -V Apple.Chr11.vcf \
#    -V Apple.Chr12.vcf \
#    -V Apple.Chr13.vcf \
#    -V Apple.Chr14.vcf \
#    -V Apple.Chr15.vcf \
#    -V Apple.Chr16.vcf \
#    -V Apple.Chr17.vcf \
#    -out Apple.Final.vcf \
#    -assumeSorted ;



java -Xmx400g -jar ${Picard} MergeVcfs \
    I=Apple.Chr00.vcf \
    I=Apple.Chr01.vcf \
    I=Apple.Chr02.vcf \
    I=Apple.Chr03.vcf \
    I=Apple.Chr04.vcf \
    I=Apple.Chr05.vcf \
    I=Apple.Chr06.vcf \
    I=Apple.Chr07.vcf \
    I=Apple.Chr08.vcf \
    I=Apple.Chr09.vcf \
    I=Apple.Chr10.vcf \
    I=Apple.Chr11.vcf \
    I=Apple.Chr12.vcf \
    I=Apple.Chr13.vcf \
    I=Apple.Chr14.vcf \
    I=Apple.Chr15.vcf \
    I=Apple.Chr16.vcf \
    I=Apple.Chr17.vcf \
    O=Final.raw2d .Apple.vcf ;
