#! /bin/sh
set -euxo pipefail


Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"
EndLocation="/data/pabster212/01.Malus_Snp/03.BaseRecal_Varaiant"



#java -jar GenomeAnalysisTK.jar \
#-T GenotypeGVCFs \
#-R reference.fasta \
#--dbsnp dbsnp_138.b37.vcf \
#--variant sample1.g.vcf.gz ... sampleN.g.vcf.gz \
#-L $chr \
#-newQual \
#-o joint_$chr.vcf

for chr in `cat ${1}`; do

java -jar ${Gatk} \
  -T GenotypeGVCFs \
  -R ${Referance}.fa \
  -L  $chr \
  --variant FilesTest.list\
  -o /tmp/Apple.$chr.vcf ;

 done 

