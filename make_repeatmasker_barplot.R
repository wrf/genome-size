# generate barplot of repeatmasker output
# must be preprocessed using python script
# repeatmasker_to_summary.py
#
# ~/git/genome-size/repeatmasker_to_summary.py hg38.fa.out.gz > hg38.fa.out.summary.tab
#
# based on data (hg38.fa.out.gz) from:
# http://repeatmasker.org/species/hg.html
# http://repeatmasker.org/genomicDatasets/RMGenomicDatasets.html
#

repeat_data = read.table( "~/genomes/human/hg38.fa.out.summary.tab", header=FALSE, sep="\t")

sorted_bases = sort(repeat_data[1:66,3], decreasing=TRUE, index.return=TRUE )
fullnames = repeat_data[,1][sorted_bases$ix][1:10]
shortnames = c("LINE1","SINE-Alu", "ERVL-MaLR", "LINE2", "ERV1", "SINE-MIR", "Simple", "ERVL", "hAT-Charlie", "TcMar-Tigger")

top_percents = repeat_data[,4][sorted_bases$ix][1:10]
top_percents
sum(top_percents)

colorset = c("#084594", "#ae017e", "#c7e9c0", "#4292c6" ,"#a1d99b", "#dd3497", "#121212", "#41ab5d", "#ef6548", "#fc8d59")

sum(repeat_data[,4])

pdf(file="~/git/genome-size/images/human_GRCh38.repeat_top_10_barplot.pdf", width=7, height=6)
par(mar=c(5,7,0.5,0.5))
barplot(sorted_bases$x[1:10], names=shortnames, las=2, axes=FALSE, xlab="Megabases", col=colorset, cex.lab=1.5, horiz=TRUE)
axis(1, at=c(0,1e8,2e8,3e8,4e8,5e8), labels=c("0","100","200","300","400","500"), cex.axis=1.4)
text(sorted_bases$x[1:10]/2, seq(0.7,11.5,1.2), paste0(round(top_percents,digits=1),"%"), col=c("white","white","black","black","black","black","white","black","black","black") )
dev.off()

png(file="~/git/genome-size/images/human_GRCh38.repeat_top_10_barplot.png", width=630, height=540)
par(mar=c(5,7,0.5,0.5))
barplot(sorted_bases$x[1:10], names=shortnames, las=2, axes=FALSE, xlab="Megabases", col=colorset, cex.lab=2, horiz=TRUE, cex.names=1.3)
axis(1, at=c(0,1e8,2e8,3e8,4e8,5e8), labels=c("0","100","200","300","400","500"), cex.axis=2)
text(sorted_bases$x[1:10]/2, seq(0.7,11.5,1.2), paste0(round(top_percents,digits=1),"%"), col=c("white","white","black","black","black","black","white","black","black","black") )
dev.off()



#