# plot prokaryote gene expression vs eukaryotic
#
# data from Methylococcus transcriptomes




mc1dat = read.table("~/genomes/methylococcus_capsulatus_PROK/SRR4116464_hisat2.cov.histo.tab", sep="\t")
mc2dat = read.table("~/genomes/methylococcus_capsulatus_PROK/SRR4116468_hisat2.cov.histo.tab", sep="\t")
mc3dat = read.table("~/genomes/methylococcus_capsulatus_PROK/SRR4116471_hisat2.cov.histo.tab", sep="\t")

cov1 = mc1dat[,1]
bases1 = mc1dat[,2]

covlog1 = round(log10(mc1dat[,1]))
covlog1[-Inf] = 0
covlog2 = round(log10(mc2dat[,1]))
covlog2[-Inf] = 0
covlog3 = round(log10(mc3dat[,1]))
covlog3[-Inf] = 0

pdf(file="~/git/genome-size/images/methylococcus_txome_expression_log_v1.pdf", width=6, height=5)
par(mar=c(4.5,4.5,3,1))
plot(mc1dat, type='l', log='xy', xlim=c(1e1,1e6), ylim=c(10,2e4), lwd=4, frame.plot=FALSE,
     xlab="Expression level (log coverage)", ylab="Bases expressed (log bp)",
     main="Methylococcus capsulatus (Bath strain) transcriptome",
     col="#bf812dbb", cex.lab=1.4, cex.axis=1.3 )
lines(mc2dat, lwd=4, col="#92c5debb")
lines(mc3dat, lwd=4, col="#21ac66bb")
legend(x="topright",legend=c("REP3-NMS-CH4", "REP1-NMS-MeOH", "REP2-AMS-MeOH"),
       pch=15, col=c("#bf812d", "#92c5de", "#21ac66"), cex=1.1, bty='n' )
dev.off()

bases_by_logcov1 = aggregate(mc1dat[,2], list(covlog1), sum)
bases_by_logcov2 = aggregate(mc2dat[,2], list(covlog2), sum)
bases_by_logcov3 = aggregate(mc3dat[,2], list(covlog3), sum)

pdf(file="~/git/genome-size/images/methylococcus_txome_expression_agg_log_v1.pdf", width=6, height=5)
par(mar=c(4.5,4.5,3,1))
plot(bases_by_logcov1, log='y', type='l', lwd=8, frame.plot=FALSE,
     xlab="Expression level (log coverage)", ylab="Bases expressed (log bp)",
     main="Methylococcus capsulatus (Bath strain) transcriptome",
     col="#bf812dbb", cex.lab=1.4, cex.axis=1.3 )
lines(bases_by_logcov2, lwd=8, col="#92c5debb")
lines(bases_by_logcov3, lwd=8, col="#2166acbb")
legend(x="topright",legend=c("REP3-NMS-CH4", "REP1-NMS-MeOH", "REP2-AMS-MeOH"),
       pch=15, col=c("#bf812d", "#92c5de", "#2166ac"), cex=1.1, bty='n' )
dev.off()


