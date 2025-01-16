#!/bin/bash

# Load necessary modules
module load sratoolkit
module load fastp
module load seqtk
module load mafft
module load raxml/8.2.12-PTHREAD
module load iqtree
module load python
module load quicktree

# Download sequencing data
fasterq-dump --split-files SRR31810373
fasterq-dump --split-files SRR31810375
fasterq-dump --split-files SRR31810376
fasterq-dump --split-files SRR31810374

# Extract 10 pairs to create a subset of the data. 
for sample in SRR31810373 SRR31810374 SRR31810375 SRR31810376; do
  head -n 80 ${sample}_1.fastq > ${sample}_1_20.fq
  head -n 80 ${sample}_2.fastq > ${sample}_2_20.fq
done

# Run fastp for quality trimming
for sample in SRR31810373 SRR31810374 SRR31810375 SRR31810376; do
  fastp -i ${sample}_1_20.fq -I ${sample}_2_20.fq -o trimmed_${sample}_1_20.fq -O trimmed_${sample}_2_20.fq \
        --length_required 50 --thread 1 --html fastp_${sample}.html --json fastp_${sample}.json
done

# Merge paired-end reads using PEAR
for sample in SRR31810373 SRR31810374 SRR31810375 SRR31810376; do
  pear -f trimmed_${sample}_1_20.fq -r trimmed_${sample}_2_20.fq -o merged_${sample}
done

# Convert FASTQ to FASTA
for sample in SRR31810373 SRR31810374 SRR31810375 SRR31810376; do
  seqtk seq -A merged_${sample}.assembled.fastq > merged_${sample}.assembled.fasta
done

# Merge all FASTA files into one input file
cat merged_*.assembled.fasta > testinput.fasta

# Manually check the testinput.fasta before proceeding to next steps.
cat testinput.fasta

# Perform multiple sequence alignment
mafft --auto testinput.fasta > output_algn.fasta

# Generate phylogenetic trees using RAxML
raxml -s output_algn.fasta -n raxml1000_tree -m GTRCAT -p 1000

# Run IQ-TREE
iqtree -s output_algn.fasta -m GTR+I+G -bb 1000

# Convert alignment to Stockholm format
python stoc_convert.py

# Tree reconstruction tools
# RapidNJ https://github.com/somme89/rapidNJ
../bin/rapidnj -i sth output_algn.sto -o t -x outputraxl_treesra.newick

# Quicktree
quicktree -in a -out t output_algn.sto > quicktree.nwk

echo "Pipeline completed successfully!"
