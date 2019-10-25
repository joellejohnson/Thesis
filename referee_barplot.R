data=read.csv("../referee_test_counts_3.txt",header=FALSE, sep=" ")
dt2=data[order(data$V2),]
dt3=aggregate(.  ~ V2, dt2, sum)

barplot(dt3$V1, log = 'y', main = "Referee Quality Score Counts", 
        xlab = "Quality Scores", ylab = "Counts", names.arg = dt3$V2, las=1)

