MQ = read.csv("../jj2_sub_DT1_DT2_jj2_135.txt", header =FALSE, sep ="\t")
MQjac = read.csv("../jj2_sub_DT1_DT2_new_jac_135.txt", header = FALSE, sep = "\t")

MQ2= (MQ$V3 - MQjac$V3)
den=density(MQ2)
plot(den, log ='y', main = "Density Plot of log of Callitrhix penicillata minus Callithrix jacchus Mapping Quality Scores", ylab = "Log10(density)")

