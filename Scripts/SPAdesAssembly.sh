#!/bin/bash
module load spades/3.10.1

##For one Plot:
		
#Assembling Reads for $ID
spades.py --careful -t 11 -m 100 \
-1 Plot1.merged.processed.1P.fastq \
-2 Plot1.merged.processed.2P.fastq \
-s Plot1.merged.processed.U.fastq \
-o Plot1.SPAdesRun

