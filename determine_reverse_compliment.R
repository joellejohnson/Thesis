paf = "jacchus_old_penicillatajj2.paf"

library(tidyr)
library(gtools)
library(readr)
library(dplyr)
library(stringr)

dat = read_tsv(paf,col_names=FALSE)

res = dat %>% filter(str_detect(X1,"^chr") & X1 == str_c("chr",X6)) %>%
    group_by(X1,X6,X5) %>% summarize(s = sum(X11))

strand = res %>% spread(X5,s) %>% mutate(pos=`+`/(`+`+`-`)) %>%
    arrange(pos)

