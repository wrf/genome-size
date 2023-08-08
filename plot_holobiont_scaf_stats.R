# plot holobiont scaffold stats
#
# using Sycon ciliatum data, including 2x symbionts
# data processed by:
#
# ~/prodigal-v2.6.3/prodigal.linux -a sycon.all_scaf.prots.fa -d sycon.all_scaf.nucls.fa -f gff -o sycon.all_scal.prodigal.gff -i sycon.genome.fa -p meta
#
# gtfstats.py -i sycon.all_scal.prodigal.gff -c -g --print-exons | sed s/_/' '/ > sycon.all_scal.prodigal.cds_lengths.txt

sycon_data = read.table("~/genomes/sycon_ciliatum_PORI/sycon.all_scal.prodigal.cds_lengths.txt")

max_pos = aggregate(sycon_data[,4], by = list(sycon_data[,1]), FUN=max)
max_pos$x

is_over_100k = max_pos$x > 100000

num_genes = aggregate(sycon_data[,2], by = list(sycon_data[,1]), FUN=max)
plot( log10(max_pos$x), max_pos$x/num_genes$x, pch=16, col="#03b62622" )


avg_len = aggregate(sycon_data[,5], by = list(sycon_data[,1]), FUN=mean)
plot( log10(max_pos$x), avg_len$x, pch=16, col="#b6032622" )

med_len = aggregate(sycon_data[,5], by = list(sycon_data[,1]), FUN=median)
plot( log10(max_pos$x)[is_over_100k], med_len$x[is_over_100k], 
      pch=16, col="#b6260322" , 
      xlim=c(3.8,6.5), ylim=c(0,1200) )

total_genic = aggregate(sycon_data[,5], by = list(sycon_data[,1]), FUN=sum)
plot( (total_genic$x/max_pos$x)[is_over_100k], med_len$x[is_over_100k], 
      pch=16, col="#b6260322" , cex=log10(total_genic$x)[is_over_100k]/2,
      xlim=c(0,1), ylim=c(0,1200) )


dev.off()










#