# Z-VCFAA-

## Extracting Protein Sequences from VCF using Zebrafish Genome

This repository provides a workflow for generating FASTA files from VCF data and translating them into protein sequences using a reference genome and GTF annotation.

## 1. Clone the Repository

To get started, clone this repository:

```bash
git clone https://github.com/Hirata-lab-2023/Z-VCFAA-.git
cd Z-VCFAA-
```

## 2. Setup Environment

### Install Required Tools
Ensure you have the following tools installed:

```bash
sudo apt update && sudo apt install -y bcftools samtools gffread wget
```

## 3. Download Reference Data

### Download Zebrafish Genome Reference (GRCz11)
```bash
mkdir -p data
cd data
wget ftp://ftp.ensembl.org/pub/release-109/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
gunzip Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
cd ..
```

### Download Zebrafish GTF Annotation (Release 109)
```bash
cd data
wget ftp://ftp.ensembl.org/pub/release-109/gtf/danio_rerio/Danio_rerio.GRCz11.109.gtf.gz
gunzip Danio_rerio.GRCz11.109.gtf.gz
cd ..
```

## 4. Generate FASTA from VCF and Translate to Protein Sequences

### Run VCF to FASTA Conversion and Protein Translation Script

Ensure that the VCF file is sorted and indexed with `tabix` before running. Also, specify the full path for the `-v` option.

```bash
bash generate_fasta.sh -v /absolute/path/to/sample.vcf.gz
```

This script will:
- Apply VCF to the reference genome
- Generate a full genome FASTA file
- Translate FASTA into protein sequences using GTF annotation
- Store the output in the `output/` directory

### Test the Workflow
Test files are provided in the `test/` directory. You can run the workflow using these sample files to verify functionality.

## 5. Repository Structure
```
.
├── data
│   ├── Danio_rerio.GRCz11.dna.primary_assembly.fa
│   ├── Danio_rerio.GRCz11.109.gtf
├── fa
│   ├── sample_full.fa
│   ├── sample_proteins.fa
├── test
│   ├── test_sample.vcf.gz
│   ├── test_sample.vcf.gz.tbi
├── generate_fasta.sh
├── README.md
```

## 6. Notes
- Reference genome and GTF must match in version (GRCz11, release 109).
- The `test/` directory contains example VCF files to validate the workflow.
