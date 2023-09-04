# replot of data from
# Shuter et al 1983 
# Phenotypic Correlates of Genomic DNA Content in Unicellular Eukaryotes and Other Cells
# The American Naturalist
# https://doi.org/10.1086/284116
#
# created by WRF 2022-11-02

shuter1983_data_file = "~/git/genome-size/data_misc/shuter_1983_all_tables.tab"

shuter1983_data = read.table(shuter1983_data_file, header = TRUE, sep = "\t")

# regression lines from paper Shuter 1983 Figure 1
# eukaryote line, ln(Vol) = 6.9 + 0.97 ln(DNA), r = 0.96; 
# prokaryote line, ln(Vol) = 20.4 + 3.52 ln(DNA), r = 0.85.

clade_color_set = c("#810f7c", "#810f7c", "#810f7c", "#810f7c", "#810f7c", 
                    "#810f7c", "#238b45", "#ce1256", "#810f7c", "#f768a1", "#02818a")

gg = ggplot( data = shuter1983_data, aes(x = DNA_pgm, y = volume_u3, color=clade)) +
  theme(legend.position="none",
        axis.text=element_text(size=16),
        axis.title=element_text(size=18),
        plot.title = element_text(size=23) ) +
  labs(x="DNA content (pgm)", y="Cell volume (um^3)",
       caption = "data from Shuter et al 1983 American Naturalist") +
  scale_x_log10(limits=c(0.001,1000)) +
  scale_y_log10(limits=c(0.01,1000000)) +
  scale_color_manual(values=clade_color_set) +
  geom_point( size=6, alpha=0.8) +
  annotate(geom="text", x=0.1, y=0.1, label="Bacteria", color="#02818a", size=6 ) +
  annotate(geom="text", x=0.01, y=1e3, label="Cyanobacteria", color="#006d2c", size=6 ) +
  annotate(geom="text", x=5, y=100, label="Eukaryotes", color="#810f7c", size=6 ) +
  annotate(geom="text", x=100, y=900, label="Dinoflagellates", color="#ce1256", size=6 ) +
  annotate(geom="text", x=50, y=1e6, label="Amoeba", color="#f768a1", size=6 )
gg

ggsave("~/git/genome-size/images/shuter_1983_figure_1.pdf", gg, device = "pdf", height = 5, width = 6)
ggsave("~/git/genome-size/images/shuter_1983_figure_1.png", gg, device = "png", dpi = 90, height = 5, width = 6)



################################################################################

# https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/

eukgenomes = read.table("~/git/genome-size/ncbi_ftp/eukaryotes.txt.gz", header = TRUE, sep="\t" , quote = "", comment.char = "", stringsAsFactors = FALSE)
eukgenomes.f = filter(eukgenomes, Status %in% c("Chromosome", "Complete Genome", "Scaffold"),
                      Genes != "-")
kingdoms = table(eukgenomes.f$Group)
#                   purple       blue         brown         green        gray
kingdom_colors = c("#7a017766", "#08309b66", "#9b083066", "#00841b66", "#88888866")
kingdom_col_index = match(eukgenomes.f$Group,names(kingdoms))

prokgenomes = read.table("~/git/genome-size/ncbi_ftp/prokaryotes.txt.gz", header = TRUE, sep="\t" , quote = "", comment.char = "", stringsAsFactors = FALSE)
prokgenomes.f = filter(prokgenomes, Status %in% c("Chromosome", "Complete Genome", "Scaffold"),
                       Genes != "-")
archaea_groups = c("Asgard group", "Candidatus Hydrothermarchaeota", "Euryarchaeota", "TACK group", "unclassified Archaea" )

pdf(file="~/git/genome-size/images/ncbi_genomes_size_vs_genes_2022.pdf", width=8, height=6)
par(mar=c(4.5,4.5,1,1))
plot(0,0,type='n',xlim=c(-0.1,4.5), ylim=c(2,5),xlab="Genome size (Mb)", ylab="Number of genes (log)", 
     frame.plot=FALSE, cex.axis=1.5, cex.lab=1.5, axes=FALSE)
axis(1, at=c(0,1,2,3,4), labels=c("1","10","100","1000","10000"), cex.axis=1.5)
axis(2, cex.axis=1.5)
points( log10(eukgenomes.f$Size..Mb.), log10(as.numeric(eukgenomes.f$Genes)), pch=16, cex=2, col=kingdom_colors[kingdom_col_index])
points( log10(prokgenomes.f$Size..Mb.) , log10(as.numeric(prokgenomes.f$Genes)), pch=16, cex=2, col=ifelse(prokgenomes$Group %in% archaea_groups, "#de851b55", "#b6260322") )
dev.off()


#