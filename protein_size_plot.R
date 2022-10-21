# comparative protein size plot
# based on SwissProt proteins
# created by WRF 2019-12-12


species = c( "E. coli", "S. cerevisiae", "H. sapiens")

num_prots = c( 4443, 6721, 20244 )

# YEEJ_ECOLI 2358 cell adhesion?
# MDN1_YEAST 4910 export of ribosomes from nucleus
# TITIN_HUMAN 34350 muscle

# https://www.ncbi.nlm.nih.gov/gene/7273
largest_prot = c( 2358, 4910, 34350 )

total_aa = c( 1385352, 3025039, 11338534 )

ecoli_prots = read.table("~/git/genome-size/uniprot_data/ecoli_uniprot.sizes", sep=" ")
ecoli_hist = hist(ecoli_prots[,2], breaks=seq(0,50000,50), plot=FALSE)
yeast_prots = read.table("~/git/genome-size/uniprot_data/yeast_uniprot.sizes", sep=" ")
yeast_hist = hist(yeast_prots[,2], breaks=seq(0,50000,50), plot=FALSE)
human_prots = read.table("~/git/genome-size/uniprot_data/human_uniprot.sizes", sep=" ")
human_hist = hist(human_prots[,2], breaks=seq(0,50000,50), plot=FALSE)

pdf(file="~/git/genome-size/comparative_protein_size_plot_v1.pdf",width=7,height=7)
par(mar=c(4.5,4.5,1,1))
plot(0,0,type='n',xlim=c(0,4000), ylim=c(0,2000), frame.plot=FALSE, xlab="Protein length (AAs)", ylab="Number of proteins", cex.axis=1.5, cex.lab=1.5)
lines(ecoli_hist$mids, ecoli_hist$counts, lwd=8, col="#005a32aa")
lines(yeast_hist$mids, yeast_hist$counts, lwd=8, col="#cc4c02aa")
lines(human_hist$mids, human_hist$counts, lwd=8, col="#7a0177aa")
text(500,1900,"Human: 20244 prots", cex=2, col="#7a0177", pos=4)
text(700,800,"Yeast: 6721 prots", cex=2, col="#cc4c02", pos=4)
text(1000,500,"E.coli: 4443 prots", cex=2, col="#005a32", pos=4)
dev.off()








