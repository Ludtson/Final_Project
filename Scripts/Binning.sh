#!/bin/bash


# Load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load anaconda/2-4.2.0_cent

# Activating environment
#source activate cpr_genome-pipe

##Running Metabat2
runMetaBat.sh -d -v -t 12 Plot1.contigs.fasta \
Plot1.1.vs.Plot1.sorted.bam \
#Plot1.2.vs.Plot1.sorted.bam \
#Plot1.3.vs.Plot1.sorted.bam \
#-o Plot1.bins
