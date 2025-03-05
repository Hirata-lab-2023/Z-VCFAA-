# Z-VCFAA-
## Extracting Protein Sequences from VCF using Zebrafish Genome

This document describes the workflow for generating FASTA files from VCF data and translating them into protein sequences using a reference genome and GTF annotation.

## 1. Setup Environment

### Install Required Tools
Ensure you have the following tools installed:

```bash
sudo apt update && sudo apt install -y bcftools samtools gffread wget
```

## 2. Download Reference Data

### Download Zebrafish Genome Reference (GRCz11)
```bash
cd data
wget ftp://ftp.ensembl.org/pub/release-109/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
gunzip Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
```

### Download Zebrafish GTF Annotation (Release 109)
```bash
wget ftp://ftp.ensembl.org/pub/release-109/gtf/danio_rerio/Danio_rerio.GRCz11.109.gtf.gz
gunzip Danio_rerio.GRCz11.109.gtf.gz
cd ..
```

## 3. Generate FASTA from VCF and Translate to Protein Sequences

### Run VCF to FASTA Conversion and Protein Translation Script

```bash
bash generate_fasta.sh -v path/to/sample.vcf.gz
```

This script will:
- Apply VCF to the reference genome
- Generate a full genome FASTA file
- Translate FASTA into protein sequences using GTF annotation
- Store the output in the `fa/` directory

## 4. Output Structure

After running the workflow, the directory structure will look like this:
```
.
├── data
│   ├── Danio_rerio.GRCz11.dna.primary_assembly.fa
│   ├── Danio_rerio.GRCz11.109.gtf
├── fa
│   ├── sample_full.fa
│   ├── sample_proteins.fa
├── generate_fasta.sh
```

## 5. Notes
- Ensure that VCF files are properly indexed (`.vcf.gz` with `.tbi` index)
- Reference genome and GTF must match in version (`GRCz11, release 109`)
