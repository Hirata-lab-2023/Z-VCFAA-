#!/bin/bash

# Reference genome FASTA file
REF="data/Danio_rerio.GRCz11.dna.primary_assembly.fa"

# Default output directory
BASE_OUT_DIR="fa"

# Parse options
while getopts "v:o:" opt; do
    case $opt in
        v) vcf="$OPTARG" ;;  # Specify VCF file
        o) BASE_OUT_DIR="$OPTARG" ;;  # Change output directory
        \?)
            echo "Usage: $0 -v <VCF file> [-o <output directory>]"
            exit 1
            ;;
    esac
done

# Check VCF file
if [[ -z "$vcf" ]]; then
    read -p "Enter the path to the VCF file: " vcf
fi

if [[ ! -f "$vcf" ]]; then
    echo "Error: VCF file not found. Exiting..."
    exit 1
fi

# Extract sample name (remove extension)
sample=$(basename "$vcf" | sed 's/.vcf.gz//')

echo "Processing VCF: $vcf (Sample: $sample)"

# Create output directory
OUT_DIR="$BASE_OUT_DIR"
mkdir -p "$OUT_DIR"

# Get sample name from VCF
sample_name=$(bcftools query -l "$vcf" | head -n 1)

# **1. Apply VCF to reference genome and create full.fa**
full_fasta="$OUT_DIR/${sample}_full.fa"
echo "Applying VCF to entire reference genome for $sample..."
bcftools consensus -f "$REF" --iupac-codes -s "$sample_name" "$vcf" > "$full_fasta"

echo "✅ FASTA generation complete. File saved as $full_fasta"

# **2. Generate protein sequences using gffread**
proteins_fa="$OUT_DIR/${sample}_proteins.fa"
echo "Generating protein sequences for $sample..."
gffread -y "$proteins_fa" -g "$full_fasta" data/Danio_rerio.GRCz11.109.gtf

echo "✅ Protein FASTA file generated: $proteins_fa"
