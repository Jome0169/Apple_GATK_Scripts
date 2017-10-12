#! /bin/sh
set -euxo pipefail
Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
GoldenSnps="/home/pabster212/01.Malus_Snp/02.CreateGoldenSnps/Round4_filtered.vcf"
Referance="Apple_genome_v1.1"
EndLocation="/data/pabster212/01.Malus_Snp/03.BaseRecal_Varaiant"
SelectedIndividuals=$1


for i in `cat ${SelectedIndividuals}` ; do gunzip ${i} ; \
    RemveEndind=${i%.dedup*.bam*} ; \
    BasefileName=${RemveEndind##*/} ;\
    TrueBase=${BasefileName%_*}; FirstLetter="$(echo $TrueBase | head -c 1)";
    echo ${RemveEndind};
    echo ${BasefileName};
    echo ${FirstLetter}

    if [ $FirstLetter == "A" ];then 
        Library=1
    elif  [ $FirstLetter == "M" ]; then 
        Library=2    
    elif [ $FirstLetter == "R" ]; then
        Library=3
    elif [ $FirstLetter == "C" ]; then
        Library=4
    fi ;

    echo ${Library}
    
    java -jar ${Picard} AddOrReplaceReadGroups \
      I=${BasefileName}.dedup_reads.bam \
      O=${BasefileName}.dedup_read_RGID.bam \
      RGID=$BasefileName \
      RGLB=${Library} \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=${TrueBase};

    java -jar ${Picard} BuildBamIndex \
    I=${BasefileName}.dedup_read_RGID.bam;



##Remove the old bam file, we do not nead it anymore


echo "Base Recal 1 "
java -jar ${Gatk} \
    -nct 15 \
    -T BaseRecalibrator \
    -R ${Referance}.fa \
    -I ${BasefileName}.dedup_read_RGID.bam \
    -knownSites ${GoldenSnps} \
    -o ${BasefileName}.pre_recal_data.table ;


echo "base recal 2 "
java -jar ${Gatk} \
    -nct 15 \
    -T BaseRecalibrator \
    -R ${Referance}.fa \
    -I ${BasefileName}.dedup_read_RGID.bam \
    -knownSites ${GoldenSnps} \
    -BQSR ${BasefileName}.pre_recal_data.table \
    -o ${BasefileName}.post_recal_data.table ;

echo "ANALYZE CO VARIATION"
java -jar ${Gatk} \
    -T AnalyzeCovariates \
    -R ${Referance}.fa \
    -before ${BasefileName}.pre_recal_data.table \
    -after ${BasefileName}.post_recal_data.table \
    -plots ${BasefileName}.recalibration_plots.pdf;


echo "CHANGE READS"
java -jar ${Gatk} \
    -T PrintReads \
    -R ${Referance}.fa \
    -I ${BasefileName}.dedup_read_RGID.bam \
    -BQSR ${BasefileName}.pre_recal_data.table \
    -o ${BasefileName}.BaseRecal.bam;

echo "GETTING GVCF"
java -jar ${Gatk} \
    -nct 15 \
    -R ${Referance}.fa \
    -T HaplotypeCaller \
    -I ${BasefileName}.BaseRecal.bam \
    --emitRefConfidence GVCF \
    -stand_call_conf 30 \
    -o ${BasefileName}.varcall.g.vcf ;

#Store Old Files
rm ${BasefileName}.BaseRecal.bam ;
gzip ${BasefileName}.dedup_read_RGID.bam ;
gzip  ${BasefileName}.pre_recal_data.table;
gzip ${BasefileName}.post_recal_data.table;

#Move Final Products
mv ${BasefileName}.varcall.g.vcf ${EndLocation};
mv ${BasefileName}.recalibration_plots.pdf ${EndLocation};
#rm ${BasefileName}.dedup_reads.bam ;


done 


