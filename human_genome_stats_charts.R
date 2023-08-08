#

#seats = c(102, 94, 18)
#partylabs = c("Sensible Party", "Silly Party", "Dangerous Party")
#pie(seats,clockwise=TRUE, partylabs)
#
#barplot(seats, names=partylabs)

#Homo sapiens	578	145.139	3253.8	128.2	1666.1	1.4	159.9	1798622	294	1638377	6793	GRCh38.p11	x	2001	9

EXON = 128.2
TOTAL = 3253.8
GENE = 1666.1
INTRON = GENE - EXON
INTERGENIC = TOTAL - GENE

features = c(EXON, INTRON, INTERGENIC)
feature_percentages = round(features * 100 / TOTAL,digits=1)
feature_percentages

pdf(file="~/git/genome-size/human_GRCh38.p11_feature_piechart.pdf", width=6, height=6)
pie( features, clockwise=TRUE, col=c("#25f283", "#e52323", "#7173e9"), labels=paste( c("Exons", "Introns", "Intergenic"),feature_percentages,"%"), cex=2 )
abline(v=0, lty=2, col="#00000088")
dev.off()












#