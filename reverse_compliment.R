library(Biostrings)
dna = readDNAStringSet("callithrix_penicillata_jj1.fasta")
chr = c("chr17", "chr8", "chrX", "chr13", "chr12", "chr21", "chr6", "chr7", "chr15", "chr16", "chr1", "chr9", "chr10")

for (s in chr) {
  dna[s] = reverseComplement(dna[s])
}

writeXStringSet(dna, "callithrix_penicillata_jj2.fasta")

