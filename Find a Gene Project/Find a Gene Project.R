#Q7 Heatmap

library(bio3d)
aln <- read.fasta("alignment.fasta")

seqIdenMatrix <- seqidentity(aln)

#install.packages("pheatmap")
library(pheatmap)

pheatmap(seqIdenMatrix)

