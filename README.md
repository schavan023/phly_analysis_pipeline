# Phylogenetic Analysis Pipeline

This repository contains a **bioinformatics pipeline** for processing sequencing data, performing multiple sequence alignments, and constructing phylogenetic trees. The workflow consists of a **Bash script (`phlyo_workflow.sh`)** for sequence processing and an accompanying **Python script (`stoc_convert.py`)** for converting alignment formats.

## 📌 Features
- **Download** sequencing reads from NCBI SRA
- **Quality trim** reads using `fastp`
- **Merge** paired-end reads with `PEAR`
- **Convert** FASTQ to FASTA using `seqtk`
- **Perform multiple sequence alignment** with `MAFFT`
- **Construct phylogenetic trees** using `RAxML`, `IQ-TREE`, `RapidNJ`, `Quicktree`, and `FastME`
- **Convert alignment formats** (FASTA to Stockholm) using `Biopython`

---

## 🚀 Getting Started

```bash
git clone https://github.com/YOUR_USERNAME/phylo_analysis_pipeline.git
cd phylo_analysis_pipeline

### ** Install dependencies**
```bash
module load sratoolkit fastp seqtk mafft raxml iqtree python quicktree
pip install biopython

### ** Run Pipeline**
```bash
chmod +x workflow.sh
./workflow.sh


📦 phylo_analysis_pipeline
├── phlyo_workflow.sh         # Main Bash script for sequence processing & tree construction
├── stoc_convert.py     # Python script to convert alignment formats
├── README.md           # Documentation
└── (Generated output files)


### Output Files
- Aligned sequences → output_algn.fasta
- RAxML tree → RAxML_bestTree.raxml1000_tree
- IQ-TREE output → output_algn.fasta.contree
- Stockholm alignment → output_algn.sto
