#!/bin/bash

### STEP 1: PROCESSING READS

################  CLIPPING ADAPTER FILTERING FOR QUALITY SCORES AND TRIMMING SHORT READS 

java -jar ~/.conda/pkgs/trimmomatic-0.39-1/share/trimmomatic-0.39-1/trimmomatic.jar  PE -threads 8 Plot1.2.raw.R1.fq Plot1.2.raw.R2.fq \
	Plot1.2.processed.1P.fastq \
	Plot1.2.processed.1U.fastq \
	Plot1.2.processed.2P.fastq \
	Plot1.2.processed.2U.fastq \
		ILLUMINACLIP:TrueSeq3-PE.fa:2:30:10 \
		LEADING:3 \
		TRAILING:3 \
		SLIDINGWINDOW:6:30 \
		MINLEN:30 \

##Checking Trimomatric output

echo "Checking Trimmomatic run:"

a=`cat Plot1.2.processed.1P.fastq  | wc -l` #storing the number of lines of file "1P" in variable 'a'
b=`cat Plot1.2.processed.2P.fastq | wc -l` #storing the number of lines of file "2P" in variable 'b'

#Compare the number of lines. If they are differnt (indicating different number of reads in the paired files) then print error message.

if [ "$a" -ne "$b" ];
	then
		echo "ERROR: Cleaned paired files are assymetrical. Re-run Trimmomatric" 
		exit 1 
	else
		echo "Paired files are symetrical" 
fi
exit 198