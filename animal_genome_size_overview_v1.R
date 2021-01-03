# plot overview of animal genome sizes
# based on data from
# http://www.genomesize.com/
#
# created by WRF 2021-01-03


# constant for c-value pg to Mb conversion
CVMB = 978

mammaldata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_mammals_2019-12-12.tab", header=TRUE, sep="\t")
mammal_sizes = log10(mammaldata[["C.value"]]*CVMB)
birddata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_birds_2019-12-12.tab", header=TRUE, sep="\t")
bird_sizes = log10(birddata[["C.value"]]*CVMB)
amphibiandata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_amphibian_2019-12-12.tab", header=TRUE, sep="\t")
frog_sizes = log10(amphibiandata[["C.value"]]*CVMB)
sharkdata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_sharks_2019-12-16.tab", header=TRUE, sep="\t")
shark_sizes = log10(sharkdata[["C.value"]]*CVMB)
rayfindata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_rayfin_fish_2019-12-16.tab", header=TRUE, sep="\t")
rayfin_sizes = log10(rayfindata[["C.value"]]*CVMB)
lobefindata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_lobefin_fish_2019-12-16.tab", header=TRUE, sep="\t")
lobefin_sizes = log10(lobefindata[["C.value"]]*CVMB)
crustaceadata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_crustacea_2019-12-12.tab", header=TRUE, sep="\t")
prawn_sizes = log10(crustaceadata[["C.value"]]*CVMB)
hexapoddata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_hexapod_2019-12-12.tab", header=TRUE, sep="\t")
hexapod_sizes = log10(hexapoddata[["C.value"]]*CVMB)
wormdata = read.table("~/git/genome-size/animalgenome_data/animalgenomes_annelida_2019-12-12.tab", header=TRUE, sep="\t")
worm_sizes = log10(wormdata[["C.value"]]*CVMB)

pdf(file="~/git/genome-size/images/animalgenomes_combined_animals_v1.pdf", width=8, height=6)
par(mar=c(4.5,1,1,1))
plot(0,0,type='n',xlim=c(0.8,5.2), ylim=c(0,3),xlab="Genome size (log)", ylab="", frame.plot=FALSE, cex.axis=1.5, cex.lab=1.5, axes=FALSE)
axis(1, at=c(1,2,3,4,5), labels=c("10 Mb","100 Mb","1 Gb","10 Gb","100 Gb"), cex.axis=1.5)
points(mammal_sizes,rep(0.3,length(mammal_sizes))+rnorm(length(mammal_sizes),sd=0.08), pch=16, cex=2, col="#017a7722")
text(4,0.3,"Mammals",pos=4,cex=2,col="#017a77")
points(frog_sizes,rep(0.8,length(frog_sizes))+rnorm(length(frog_sizes),sd=0.08), pch=16, cex=2, col="#7a017722")
text(2.8,0.8,"Amphibians",pos=2,cex=2,col="#7a0177")
points(bird_sizes,rep(0.3,length(bird_sizes))+rnorm(length(bird_sizes),sd=0.08), pch=16, cex=2, col="#65a0bc22")
text(2.8,0.3,"Birds",pos=2,cex=2,col="#65a0bc")
points(shark_sizes,rep(1.3,length(shark_sizes))+rnorm(length(shark_sizes),sd=0.08), pch=16, cex=2, col="#08519c22")
points(rayfin_sizes,rep(1.3,length(rayfin_sizes))+rnorm(length(rayfin_sizes),sd=0.08), pch=16, cex=2, col="#08519c22")
points(lobefin_sizes,rep(1.3,length(lobefin_sizes))+rnorm(length(lobefin_sizes),sd=0.08), pch=16, cex=2, col="#08519c22")
text(2.5,1.3,"Fish",pos=2,cex=2,col="#08519c")
points(prawn_sizes,rep(1.8,length(prawn_sizes))+rnorm(length(prawn_sizes),sd=0.08), pch=16, cex=2, col="#ca444422")
text(2.0,1.8,"Crustaceans",pos=2,cex=2,col="#ca4444")
points(hexapod_sizes,rep(2.3,length(hexapod_sizes))+rnorm(length(hexapod_sizes),sd=0.08), pch=16, cex=2, col="#ca991b22")
text(4.3,2.3,"Hexapods",pos=4,cex=2,col="#ca991b")
points(worm_sizes,rep(2.8,length(worm_sizes))+rnorm(length(worm_sizes),sd=0.08), pch=16, cex=2, col="#994f0022")
text(4.0,2.8,"Annelids",pos=4,cex=2,col="#994f00")
dev.off()




#