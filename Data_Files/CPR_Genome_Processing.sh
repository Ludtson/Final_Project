#! /bin/bash

# Final_Project
# Written By: Adekola Oluwatosin Owoyemi, Giovani Rossi, and Frank Moen, 
# Graduate Students at Auburn University, Department of Biological Sciences
# Class: BIOL 7180, Scripting for Biologists
# Professor: Dr. Scott R. Santos
# Last Updated: 4/15/2020 2:01PM

###################################################################################################
# Instructions:
# Before using this script:
# Make sure data files are in FASTQ format and in the SAME directory as 
# the script (CPR_Genome_Processing.sh)
# For this particular script make sure to use this particular naming scheme:
#	Plot1.1.raw.R1.fq for Read 1
#	Plot1.1.raw.R2.fq for Read 2
# Make sure all scripts are set to executable as in the example instructions
# Verify that all the dependencies and channels listed below are
# available where the script is being run
####################################################################################################
#channels:
  #- bioconda
  #- conda-forge
  #- defaults
#dependencies:
  #- trimmomatic=0.39
  #- spades=3.14.0
  #- bwa=0.7.15
  #- metabat2=2.15.0
  #- checkm-genome=1.1.2

sleep 1
printf "\n"
sleep 1
printf "Welcome to CPR_Genome_Processing~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
sleep 1
printf "\n"

#Setting up folders for Unprocessed and Processed FASTQ files to have copies
mkdir Unprocessed_Fastq_Reads
cp ./Plot1.* ./Unprocessed_Fastq_Reads
mkdir Processed_Fastq_Reads

#Running the tool Trimmomatic on the FASTQ files
#This will trim adapters, low quality ends of reads, discard reads shorter than 30bp
printf "1. Running ReadProccessing on FASTq (this step may take a few seconds) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
~/Final_Project/Final_Project/Scripts/ReadProcess.sh
cp *.processed* ./Processed_Fastq_Reads

#Concatenating replicates FASTQ files
cat Plot1*1P.fastq >> Plot1.merged.processed.1P.fastq
cat Plot1*2P.fastq >> Plot1.merged.processed.2P.fastq
cat Plot1*U.fastq >> Plot1.merged.processed.U.fastq

#Keeping working directory clean and removing unnecessary files
rm ./Plot1.?.processed.*

#Running the tool SPAdes on the FASTQ files
#This will assemble the reads from the previous step into contigs
printf "2. Running SPAdesAssembly on ReadProcessing Output (this step may take a few hours) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
~/Final_Project/Final_Project/Scripts/SPAdesAssembly.sh

#Keeping working directory clean, creating new directories, and copying files into those directories
mkdir Merged_Processed_Fastq_Reads
mv ./*.merged.* ./Merged_Processed_Fastq_Reads
cp ./Plot1.SPAdesRun/contigs.fasta ./
mv ./contigs.fasta ./Plot1.contigs.fasta
cp ./Processed_Fastq_Reads/*.1P* ./
cp ./Processed_Fastq_Reads/*.2P* ./

#Running the tools BWA and Samtools
#This will map the original reads back to the assembled contigs
#BWA : map reads back to assembled contigs
#Samtools: extract paried mapped reads
printf "3. Running Mapping on SPAdesAssembly Output~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
~/Final_Project/Final_Project/Scripts/Mapping.sh

#Keeping working directory clean, creating new directories, and copying files into those directories
mkdir Fasta_Files
mkdir Sam_Files
mkdir Sai_Files

cp ./*.fasta.* ./Fasta_Files
cp ./*.sam.* ./Sam_Files
cp ./*.sam ./Sam_Files
cp ./*.sai ./Sai_Files

#Keeping working directory clean and removing unnecessary files
rm ./*.fasta.* *.sam.* *.sai *.sam *.processed.*

#Running the tool MetaBat2
#This will bin or separate the genomes into FASTA files
printf "4. Running Binning on Mapping Output~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
~/Final_Project/Final_Project/Scripts/Binning.sh
mv ./Plot1.contigs.fasta.metabat-bins12/ ./Plot1.bins

#Running the tool CheckM
#This will asses the quality of the genomes that were binned
printf "5. Running CheckM on Binning Output~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
~/Final_Project/Final_Project/Scripts/CheckM.sh

#Keeping working directory clean, creating new directories, and copying files into those directories
mkdir Cluster_Log_Files
mkdir Bam_Files

cp ./*cluster.* ./Cluster_Log_Files
cp ./*.bam ./Bam_Files
cp ./*.fasta ./Fasta_Files
cp ./*.fasta.* ./Fasta_Files

#Keeping working directory clean and removing unnecessary files
rm ./cluster.*
rm ./*.bam
rm ./*.fasta.*
rm ./*.fasta

printf "CPR_Genome_Proccessing.sh has completed, the CheckM output folder Plot1.CheckMrun contains 
genes identified, annotation for each bin, and other data for Phylogenetic analysis."

exit 192

