#!/bin/sh

source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bwa/0.7.12
module load samtools/1.2

#Creating Reference Genome

bwa index -a bwtsw Plot1.contigs.fasta

##Running Replicate 1:

bwa aln -t 4 Plot1.contigs.fasta Plot1.1.processed.1P.fastq > Plot1.1.R1.sai ;
bwa aln -t 4 Plot1.contigs.fasta Plot1.1.processed.2P.fastq > Plot1.1.R2.sai ;
bwa sampe Plot1.contigs.fasta \
Plot1.1.R1.sai \
Plot1.1.R2.sai \
Plot1.1.processed.1P.fastq \
Plot1.1.processed.2P.fastq \
> Plot1.1.vs.Plot1.sam ;
				
#Creating bam files with only paired reads
samtools flagstat Plot1.1.vs.Plot1.sam > Plot1.1.vs.Plot1.sam.flagstat.txt ;
samtools view -@ 4 -F 0x04 -uS Plot1.1.vs.Plot1.sam | samtools sort -@ 4 - Plot1.1.vs.Plot1.sorted ;

##Running Replicate 2:

#bwa aln -t 4 Plot1.contigs.fasta Plot1.2.processed.1P.fastq > Plot1.2.R1.sai ;
#bwa aln -t 4 Plot1.contigs.fasta Plot1.2.processed.2P.fastq > Plot1.2.R2.sai ;
#bwa sampe Plot1.contigs.fasta \
#Plot1.2.R1.sai \
#Plot1.2.R2.sai \
#Plot1.2.processed.1P.fastq \
#Plot1.2.processed.2P.fastq \
#> Plot1.2.vs.Plot1.sam ;
				
#Creating bam files with only paired reads
#samtools flagstat Plot1.2.vs.Plot1.sam > Plot1.2.vs.Plot1.sam.flagstat.txt ;
#samtools view -@ 4 -F 0x04 -uS Plot1.2.vs.Plot1.sam | samtools sort -@ 4 - Plot1.2.vs.Plot1.sorted ;

##Running Replicate 3:

#bwa aln -t 4 Plot1.contigs.fasta Plot1.3.processed.1P.fastq > Plot1.3.R1.sai ;
#bwa aln -t 4 Plot1.contigs.fasta Plot1.3.processed.2P.fastq > Plot1.3.R2.sai ;
#bwa sampe Plot1.contigs.fasta \
#Plot1.3.R1.sai \
#Plot1.3.R2.sai \
#Plot1.3.processed.1P.fastq \
#Plot1.3.processed.2P.fastq \
#> Plot1.3.vs.Plot1.sam ;
				
#Creating bam files with only paired reads
#samtools flagstat Plot1.3.vs.Plot1.sam > Plot1.3.vs.Plot1.sam.flagstat.txt ;
#samtools view -@ 4 -F 0x04 -uS Plot1.3.vs.Plot1.sam | samtools sort -@ 4 - Plot1.3.vs.Plot1.sorted ;


