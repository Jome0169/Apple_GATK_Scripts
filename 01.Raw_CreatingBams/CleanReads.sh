#! /bin/sh

Picard="/home/jiaochen/software/picard-tools-1.141/picard.jar" # Remember to
Samtools="samtools"
Gatk="/home/pabster212/Programs/GenomeAnalysisTK.jar"
Referance="Apple_genome_v1.1"
DeDupScript="/home/pabster212/Programs/NGS_data_processing"
Trimmomatic="/home/pabster212/Programs/Trimmomatic-0.36/trimmomatic-0.36.jar"
Adapter="/home/pabster212/Programs/Trimmomatic-0.36/adapters"

for i in `cat $1`; do RemoveEnding=${i%_R1.fq.gz} ;\
    FirstLetter="$(echo $RemoveEnding | head -c 1)"; \

    
        echo "${DeDupScript} -rcDup -opre ${RemoveEnding} -subseqS 6 -subseq 84 ${RemoveEnding}_R1.fq.gz ${RemoveEnding}_R2.fq.gz > non_dup.log 2> non_dup_err "
        ${DeDupScript}/drop_dup_both_end.pl -rcDup -opre ${RemoveEnding} -subseqS 6 -subseq 84 ${RemoveEnding}_R1.fq.gz ${RemoveEnding}_R2.fq.gz > non_dup.log 2> non_dup_err ;
        
        rm ${RemoveEnding}_R1.dropB; 
        rm ${RemoveEnding}_R2.dropB; 
        
        mv ${RemoveEnding}_R1.ndupB ${RemoveEnding}_R1.ndupB.fq;
        mv ${RemoveEnding}_R2.ndupB ${RemoveEnding}_R2.ndupB.fq;
        echo "GZIP"
        gzip ${RemoveEnding}_R1.ndupB.fq;
        gzip ${RemoveEnding}_R2.ndupB.fq;

        echo "TRIMMING"
        java -jar ${Trimmomatic} PE -phred33 ${RemoveEnding}_R1.ndupB.fq.gz ${RemoveEnding}_R2.ndupB.fq.gz \
        ${RemoveEnding}_R1.ndupB.paired.fq.gz ${RemoveEnding}_R1.ndupB.unpaired.fq.gz \
        ${RemoveEnding}_R2.ndupB.paired.fq.gz ${RemoveEnding}_R2.ndupB.unpaired.fq.gz \
        ILLUMINACLIP:${Adapter}/TruSeq3-PE-2.fa:2:30:10:1:TRUE SLIDINGWINDOW:4:20 LEADING:3 TRAILING:3 MINLEN:40 ;

        echo "CLEANING UP"
        rm ${RemoveEnding}_R1.ndupB.unpaired.fq.gz;
        rm ${RemoveEnding}_R2.ndupB.unpaired.fq.gz;
        rm ${RemoveEnding}_R1.ndupB.fq.gz; 
        rm ${RemoveEnding}_R2.ndupB.fq.gz;



done 
 









