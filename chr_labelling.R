# DGenies association table with penicillata as query and old jacchus as target
assoc = "Callithrix_penicillata_jacchus_old_assoc.tsv"
# Input Fasta file
dt1 = "callithrix_penicillata_dt1.fasta"
# Output Fasta File
output = "callithrix_penicillata_jj1.fasta"
# Sequence Dictionary
dict = "callithrix_penicillata_dt1.dict"

library(tidyr)
library(gtools)
library(readr)
library(dplyr)
library(stringr)

# read the sequence dictionary, modify the name, length, and md5 columns
# sort by longest scaffolds first.
dat_raw = read_tsv(dict,col_names=FALSE,skip=1)
dat = dat_raw %>% transmute(Name = str_sub(X2,4), Length = as.integer(str_sub(X3,4)), Id = str_c("scaffold_",str_sub(X4,4,4+8-1))) %>%
                  arrange(desc(Length))

# QC: Check if the first 8 characters of each MD5 are unique
# length(unique(dat$Id)) == length(dat$Id)

# Read association table and sort by Query length
assoc_dat = read_tsv(assoc,col_types="ccciiiiii",na="na") %>% 
            arrange(desc(`Q-len`))

# QC: Check that the first 25 are sorted the same in both tables
all(assoc_dat$Query[1:25] == dat$Name[1:25])

# The longest 25 scaffolds consist of Chrs 1-22, X, and pieces of Chrs 4 and 15.
# Everything below that has a length less that 500kb and starts matching various
# scaffolds.

# rename the chromosome
dat$Id[1:23] = str_c("chr",assoc_dat$Target[1:23])

# rename the two chromosome fragments
dat$Id[24:25] = str_c("chr",assoc_dat$Target[24:25],"un_",dat$Id[24:25])

# Resort the chromosomes by name
dat[1:23,] = dat[mixedorder(assoc_dat$Target[1:23]),]

# Save mapping dat
write_tsv(dat,"dt1_new_names.tsv")

###############################################################################
# Read fasta and sort
library(Biostrings)

fasta = readDNAStringSet(dt1)
new_fasta = fasta[dat$Name]
#QC: all(names(new_fasta) == dat$Name)

# rename fasta
names(new_fasta) = dat$Id

# write it out
writeXStringSet(new_fasta, output)

