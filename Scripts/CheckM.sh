#!/bin/bash

## Calling Anaconda

source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load anaconda/3-5.0.1

## Opening conda environment

source activate cpr_genome-pipe

##Runnign Check M on 8 threads for each Plot:

checkm taxonomy_wf domain Bacteria Plot1.bins Plot1.CheckMrun
