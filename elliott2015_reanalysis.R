# analysis of supplemental data from:
# Elliott and Gregory (2015) What's in a genome? The C-value enigma and the evolution of eukaryotic genome content
# http://rstb.royalsocietypublishing.org/content/370/1678/20140331

# created by WRF 2019-12-12

datatable = read.table("~/git/genome-size/elliott2015_data/rstb20140331supp1.tab", header=TRUE, sep="\t")

# manual data processing notes:
#
# line 56 did not have 44 elements Culex quinquefasciatus log intron not calculated due to error in intron count
# line 404 did not have 44 elements Mortierella alpina # symbol in name
#

head(datatable)

kingdoms = datatable[["Taxon.Group"]]
#                    purple       blue          green        red
kingdom_colors = c("#7a017766", "#08309b66", "#00841b66", "#88888866")
kingdom_col_index = match(kingdoms,names(table(kingdoms)))

genome_size = datatable[["Estimated.Genome.Size..Mb."]]
gene_count = datatable[["Gene.Number"]]

archaeadata = read.table("~/git/genome-size/refseq_data/archaea_refseq_assembly_stats_2019-12-12.tab", header=FALSE, sep='\t')
bacteriadata = read.table("~/git/genome-size/refseq_data/bacteria_refseq_assembly_stats_2019-12-12.tab", header=FALSE, sep='\t')

pdf(file="~/git/genome-size/images/refseq_proks_w_elliott2015_genome_size_vs_gene_count_v1.pdf", width=8, height=6)
par(mar=c(4.5,4.5,1,1))
plot(0,0,type='n',xlim=c(-0.1,4.5), ylim=c(2.8,5),xlab="Genome size (Mb)", ylab="Number of genes (log)", frame.plot=FALSE, cex.axis=1.5, cex.lab=1.5, axes=FALSE)
axis(1, at=c(0,1,2,3,4), labels=c("1","10","100","1000","10000"), cex.axis=1.5)
axis(2, cex.axis=1.5)
points( log10(bacteriadata[,3]/1000000), log10(bacteriadata[,4]), pch=16, cex=2, col="#b6260322")
points( log10(archaeadata[,3]/1000000), log10(archaeadata[,4]), pch=16, cex=2, col="#de851b55")
points( log10(genome_size), log10(gene_count), pch=16, cex=2, col=kingdom_colors[kingdom_col_index])
arrows(3.75,4.0,log10(genome_size[6]),log10(gene_count[6]),lwd=4)
text(3.75,4.0,"human",pos=1, cex=1.1)
legend(0,5.1,bty='n',legend=names(table(kingdoms)), pch=15, cex=2, col=c("#7a0177", "#08309b", "#00841b", "#888888"))
legend(1.5,3.3,bty='n',legend=c("Archaea", "Bacteria"), pch=15, cex=2, col=c("#de851b","#b62603"))
dev.off()


pdf(file="~/git/genome-size/images/ncbi_proks_only_genome_size_vs_gene_count_v1.pdf", width=8, height=6)
par(mar=c(4.5,4.5,1,1))
plot(0,0,type='n',xlim=c(-0.1,4.5), ylim=c(2.8,5),xlab="Genome size (Mb)", ylab="Number of genes (log)", frame.plot=FALSE, cex.axis=1.5, cex.lab=1.5, axes=FALSE)
axis(1, at=c(0,1,2,3,4), labels=c("1","10","100","1000","10000"), cex.axis=1.5)
axis(2, cex.axis=1.5)
points( log10(bacteriadata[,3]/1000000), log10(bacteriadata[,4]), pch=16, cex=2, col="#b6260322")
points( log10(archaeadata[,3]/1000000), log10(archaeadata[,4]), pch=16, cex=2, col="#de851b55")
legend(1.5,3.3,bty='n',legend=c("Archaea", "Bacteria"), pch=15, cex=2, col=c("#de851b","#b62603"))
dev.off()


pdf(file="~/git/genome-size/images/ncbi_proks_only_linear_genome_size_vs_gene_count_v1.pdf", width=8, height=6)
par(mar=c(4.5,4.5,1,1))
plot(0,0,type='n',xlim=c(0,12), ylim=c(0,11000),xlab="Genome size (Mb)", ylab="Number of genes (1000s)", frame.plot=FALSE, cex.axis=1.5, cex.lab=1.5, axes=FALSE)
axis(1, cex.axis=1.5)
axis(2, at=seq(0,10000,2000), labels=c("0","2","4","6","8","10"), cex.axis=1.5)
points( bacteriadata[,3]/1000000, bacteriadata[,4], pch=16, cex=2, col="#b6260322")
points( archaeadata[,3]/1000000, archaeadata[,4], pch=16, cex=2, col="#de851b55")
legend(0,10000,bty='n',legend=c("Archaea", "Bacteria"), pch=15, cex=2, col=c("#de851b","#b62603"))
dev.off()






#