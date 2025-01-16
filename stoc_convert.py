# Simple python script to convert the aligned sequence file from fasta to stockholm format which can be used as an input for RapidNJ tree creation. 
from Bio import AlignIO

# Read the FASTA alignment file
alignment = AlignIO.read("output_algn.fasta", "fasta")

# Write the alignment in Stockholm format
AlignIO.write(alignment, "output_algn.sto", "stockholm")

