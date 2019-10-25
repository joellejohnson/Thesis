HS_REF=/storage/reference_genomes/human/1k_genomes_GRCh38/GRCh38_full_analysis_set_plus_decoy_hla.fa
CJ_REF=/storage/reference_genomes/callithrix/jacchus/Callithrix_jacchus.ASM275486v1.dna.nonchromosomal.fa
CP_REF=../callithrix_penicillata_dt1.fasta

#Running minimap for target and query files
/home/jgjohns6/minimap2-2.12_x64-linux/minimap2 -t 20 -x asm20 $(HS_REF) $(CP_REF) > $@

/home/jgjohns6/minimap2-2.12_x64-linux/minimap2 -t 20 -x asm10 $(CJ_REF) $(CP_REF) > $@

#Creating indexed files for D-genies input
echo "Callithrix penicillata" > $@
cut -f 1,2 $(CP_REF).fai >> $@


echo "Callithrix jacchus" > $@
cut -f 1,2 $(CJ_REF).fai >> $@


echo "Homo sapiens" > $@
cut -f 1,2 $(HS_REF).fai >> $@
