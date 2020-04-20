## Final Project

### Purpose: To streamline the processes of binning complex metagenomic samples for further analysis.

### Introduction: This project was aimed at creating the pipeline CPR_Genome_Processing.sh. This script contains five major steps that streamline the analysis of the Candidate Phylum Radiation (CPR). The script starts with sequencing FASTQ files and ends with a CheckM analysis of bins produced. The five major steps of this script are listed below. In addition to these major steps, the script maintains a clearn working directory my managing output files and saving copies of them to specific directories.
```
1. Read Processing
2. SPAdes Assembly
3. Mapping
4. Binning
5. CheckM Analysis
```
**1. Read Processing**

Runs the tool Trimmomatic on the FASTQ files, which trims adapters, low quality ends of reads, discard reads shorter than 30bp.
```
TrimmomaticPE: Started with arguments:
 -threads 8 Plot1.1.raw.R1.fq Plot1.1.raw.R2.fq Plot1.1.processed.1P.fastq Plot1.1.processed.1U.fastq Plot1.1.processed.2P.fastq Plot1.1.processed.2U.fastq ILLU$
java.io.FileNotFoundException: /Final_Project/Final_Project/Data_Files/TrueSeq3-PE.fa (No such file or directory)
        at java.base/java.io.FileInputStream.open0(Native Method)
        at java.base/java.io.FileInputStream.open(FileInputStream.java:219)
        at java.base/java.io.FileInputStream.<init>(FileInputStream.java:157)
        at org.usadellab.trimmomatic.fasta.FastaParser.parse(FastaParser.java:54)
        at org.usadellab.trimmomatic.trim.IlluminaClippingTrimmer.loadSequences(IlluminaClippingTrimmer.java:110)
        at org.usadellab.trimmomatic.trim.IlluminaClippingTrimmer.makeIlluminaClippingTrimmer(IlluminaClippingTrimmer.java:71)
        at org.usadellab.trimmomatic.trim.TrimmerFactory.makeTrimmer(TrimmerFactory.java:32)
        at org.usadellab.trimmomatic.Trimmomatic.createTrimmers(Trimmomatic.java:59)
        at org.usadellab.trimmomatic.TrimmomaticPE.run(TrimmomaticPE.java:552)
        at org.usadellab.trimmomatic.Trimmomatic.main(Trimmomatic.java:80)
Quality encoding detected as phred33
Input Read Pairs: 1562120 Both Surviving: 1131818 (72.45%) Forward Only Surviving: 154231 (9.87%) Reverse Only Surviving: 126902 (8.12%) Dropped: 149169 (9.55%)
TrimmomaticPE: Completed successfully
Checking Trimmomatic run:
Paired files are symetrical
```
**2. SPAdes Assembly**

Runs the tool SPAdes on the FASTQ files, which will assemble the reads from the previous step into contigs.
```
0:00:00.274    76M / 132M  INFO    General                 (binary_converter.hpp	: 139)   16384 reads processed
  0:00:00.364    84M / 132M  INFO    General                 (binary_converter.hpp	: 139)   32768 reads processed
  0:00:00.544   104M / 132M  INFO    General                 (binary_converter.hpp	: 139)   65536 reads processed
  0:00:00.907   140M / 140M  INFO    General                 (binary_converter.hpp	: 139)   131072 reads processed
  0:00:01.628   216M / 216M  INFO    General                 (binary_converter.hpp	: 139)   262144 reads processed
  0:00:03.081   368M / 368M  INFO    General                 (binary_converter.hpp	: 139)   524288 reads processed
  0:00:06.649   620M / 620M  INFO    General                 (binary_converter.hpp	: 139)   1048576 reads processed
  0:00:07.613   212M / 636M  INFO    General                 (binary_converter.hpp	: 159)   1130727 reads written
  0:00:07.752     4M / 636M  INFO    General                 (read_converter.hpp        :  94)   Converting single reads
  0:00:08.128   136M / 636M  INFO    General                 (binary_converter.hpp	: 139)   16384 reads processed
  0:00:08.168   140M / 636M  INFO    General                 (binary_converter.hpp	: 139)   32768 reads processed
  0:00:08.249   148M / 636M  INFO    General                 (binary_converter.hpp	: 139)   65536 reads processed
  0:00:08.409   164M / 636M  INFO    General                 (binary_converter.hpp	: 139)   131072 reads processed
  0:00:08.731   200M / 636M  INFO    General                 (binary_converter.hpp	: 139)   262144 reads processed
  0:00:08.879   204M / 636M  INFO    General                 (binary_converter.hpp	: 159)   281610 reads written
```
**3. Mapping**

Runs the tools BWA and Samtools. This will map the original reads back to the assembled contigs. BWA : maps reads back to assembled contigs. Samtools: extract paried mapped reads.

```
bwa_index] Pack FASTA... 0.04 sec
[bwa_index] Construct BWT for the packed sequence...
[BWTIncCreate] textLength=12375248, availableWord=12870652
[bwa_index] 2.93 seconds elapse.
[bwa_index] Update BWT... 0.03 sec
[bwa_index] Pack forward-only FASTA... 0.03 sec
[bwa_index] Construct SA from BWT and Occ... 1.28 sec
[bwt_gen] Finished constructing BWT in 6 iterations.
[main] Version: 0.7.12-r1039
[main] CMD: bwa index -a bwtsw Plot1.contigs.fasta
[main] Real time: 4.380 sec; CPU: 4.316 sec
[bwa_aln] 17bp reads: max_diff = 2
[bwa_aln] 38bp reads: max_diff = 3
[bwa_aln] 64bp reads: max_diff = 4
[bwa_aln] 93bp reads: max_diff = 5
[bwa_aln] 124bp reads: max_diff = 6
[bwa_aln] 157bp reads: max_diff = 7
[bwa_aln] 190bp reads: max_diff = 8
[bwa_aln] 225bp reads: max_diff = 9
[bwa_aln_core] calculate SA coordinate... 10.76 sec
[bwa_aln_core] write to the disk... 0.04 sec
[bwa_aln_core] 262144 sequences have been processed.
[bwa_aln_core] calculate SA coordinate... 10.96 sec
[bwa_aln_core] write to the disk... 0.03 sec
[bwa_aln_core] 524288 sequences have been processed.
[bwa_aln_core] calculate SA coordinate... 11.08 sec
[bwa_aln_core] write to the disk... 0.04 sec
[bwa_aln_core] 786432 sequences have been processed.
[bwa_aln_core] calculate SA coordinate... 11.80 sec
[bwa_aln_core] write to the disk... 0.05 sec
[bwa_aln_core] 1048576 sequences have been processed.
[bwa_aln_core] calculate SA coordinate... 4.07 sec
[bwa_aln_core] write to the disk... 0.02 sec
[bwa_aln_core] 1131818 sequences have been processed.
[main] Version: 0.7.12-r1039
```
**4. Binning**

Runs the tool MetaBat2, which will bin or separate the genomes into FASTA files
```
MetaBAT 2 (v2.12.1) using minContig 2500, minCV 1.0, minCVSum 1.0, maxP 95%, minS 60, and maxEdges 200.
[00:00:00] Number of large contigs >= 2500 are 312.
[00:00:00] nobs = 312
[00:00:00] r = 382 (num = 312), (nskip = 0)
[00:00:00] Finished reading 382 contigs and 1 coverages from Plot1.contigs.fasta.depth.txt
[00:00:00] seqs.size = 312, contig_names.size = 312
[00:00:00] Number of target contigs: 312 of large (>= 2500) and 70 of small ones (>=1000 & <2500).
[00:00:00] Start TNF calculation. nobs = 312
```
**5. CheckM Analysis**

Run the tool CheckM, which will assess the quality of the genomes that were binned
```
[2020-04-20 00:06:58] INFO: CheckM v1.1.2
[2020-04-20 00:06:58] INFO: checkm taxonomy_wf domain Bacteria Plot1.bins Plot1.CheckMrun
[2020-04-20 00:06:58] INFO: [CheckM - taxon_set] Generate taxonomic-specific marker set.
[2020-04-20 00:07:02] INFO: Marker set for Bacteria contains 104 marker genes arranged in 58 sets.
[2020-04-20 00:07:02] INFO: Marker set inferred from 5449 reference genomes.
[2020-04-20 00:07:02] INFO: Marker set written to: Plot1.CheckMrun/Bacteria.ms
[2020-04-20 00:07:02] INFO: { Current stage: 0:00:04.340 || Total: 0:00:04.340 }
[2020-04-20 00:07:02] INFO: [CheckM - analyze] Identifying marker genes in bins.
```
## Final Project Example

### Downloading Example Data Set

**For the sake of time, energy, and memory this example is going to use one genome to test the pipeline. This will also be a controlled test as the outcome is known.**

**Visit Qiagen's website for available FastQ data of Pseudomonas aeruginosa.**

<https://digitalinsights.qiagen.com/downloads/example-data/>

**Download Illumina genomic data from Pseudomonas aeruginosa from this website.**

**Rename `SRR396637.sra_1.fastq` and `SRR396637.sra_2.fastq` to `Plot1.1.raw.R1.fq` and `Plot1.1.raw.R2.fq`, respectively.**

### Directions for Cloning repositry and executing the CPR_Genome_Processing
**Create a folder for the repository**

`mkdir Final_Project`

**Move into this new folder**

`cd Final_Project`

**Activate Git in the folder**

`git init`

**Clone the GitHub repository from our groups GitHub page**

`git clone git@github.com:fsm2020/Final_Project.git`

**Change directories into the new Final_Project**

`cd Final_Project`

**Change directories into Data_Files**

`cd Data_Files`

**This directory contains the example data files Plot1.1.raw.R1.fq & Plot1.1.raw.R2.fq**
**This directory also contains the script : CPR_Genome_Processing.sh**
**Make sure this script is executable**

`chmod +x CPR_Genome_Processing.sh`

**Make sure that the scripts in ” ~/Final_Project/Final_Project/Scripts ”  are all executable as well**
**The script CPR_Genome_Processing.sh will use these to pull from**

`cd ~/Final_Project/Final_Project/Scripts`

`chmod +x Binning.sh CheckM.sh Mapping.sh ReadProcess.sh ReadProcessing1.sh ReadProcessing2.sh ReadProcessing3.sh SPAdesAssembly.sh`

### Channels, Dependencies, and Modules
```  
  Channels:
  - bioconda
  - conda-forge
  - defaults
  Dependencies:
  - trimmomatic=0.39
  - metabat2=2.15.0
  - checkm-genome=1.1.2
  Modules:
  - module load anaconda/2-4.2.0_cent
  - module load bwa/0.7.12
  - module load samtools/1.2
  - module load spades/3.10.1
  
```
### Creating an environment with appropriate tools for CPR_Genome_Processing.sh
**Create an environment for certain tools to run**
**To do this activate anaconda**

`module load anaconda/3-2018.12`

**Then create an environment using the .yaml file in the repository**
**This should be run from the ~/Final_Project/Final_Project directory**

`conda env create -n cpr_genome-pipe –file Environments/cpr_genome_env.yaml`

**This will be activated later on in the script, so you do not need to activate it before running the script. Follow any** **prompt sent to output to make sure that the environment is correctly created**

Modules are loaded as needed within each sub-script.
Dependencies are used as needed by activating the environment as needed.

### Instructions
Before using this script:
Make sure data files are in FASTQ format and in the SAME directory as the script (CPR_Genome_Processing.sh).
In this example, make sure `Plot1.1.raw.R1.fq` and `Plot1.1.raw.R2.fq` are in the Data_Files directory with 
CPR_Genome_Processing.sh

### Running CPR Genome Processing
**Run the CPR_Genome_Processing.sh script with the ASC queue**

**Again, make sure to be in the /Data_Files directory with:**
```
Plot1.1.raw.R1.fq
Plot1.1.raw.R2.fq
CPR_Genome_Processing.sh
```
**The next step is submitting the job to the queue**

`run_script CPR_Genome_Processing.sh`

**Run Parameters**
```
Type: express
Cores: 1
Time: 1:45:00
Memory: 16gb
```
### Results and Expected Outcomes

**To see a completed example, view the `FINAL_PROJ_1.o400178` in the "/Completed_Example_Job" directory.**

This demonstrates the typical results produced by the CPR_Genome_Process.sh script
Additionally, at the bottom it is clear that `1 bin` was produced (see below). Finally, view the final output of the script in the `Final_Project/Data_Files/Plot1.CheckMrun/` directory. There is a file `Bacteria.ms` which contains information about the genome bin assessed.
```
Bin 1 (5888915 bases in 293 contigs) was saved to: Plot1.contigs.fasta.metabat-bins12/bin.1.fa
[00:00:01] 97.50% (5888915 bases) of large (>=2500) and 0.00% (0 bases) of small (<2500) contigs were binned.
1 bins (5888915 bases in total) formed.
Finished metabat2
```
This is expected behavior as we provided a FastQ file containing only 1 genome.

### Future Tests

**Next we plan to test the pipeline with a mock metagenome to see if we can obtain output similar to data our lab would want to process for future analyses. We would expect the pipeline to produce more bins corresponding with the various genomes present in the data.**


