# genome-size #
examination of genome size and content across the tree of life

Prokaryotic genome data from refseq assembly stats and feature counts were downloaded from [NCBI Assembly](https://www.ncbi.nlm.nih.gov/assembly/). This included both the "Assembly Statistics Report" and the "Feature Counts Report", for both archaea and bacteria. The data of each assembly and annotation was then combined using the python script [aggregate_size_and_features.py](https://github.com/wrf/genome-size/blob/master/aggregate_size_and_features.py).

Eukaryotic genome data were reported in the supplement of [Elliott 2015 What's in a genome? The C-value enigma and the evolution of eukaryotic genome content](https://doi.org/10.1098/rstb.2014.0331). Daily updated versions are taken from [NCBI GENOME REPORTS](https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/).

## relationship of genome size vs gene count ##
There is a rather strict relationship of genome size to gene count among prokaryotes, of approximately 1000bp per gene. 

![refseq_proks_w_elliott2015_genome_size_vs_gene_size_v1.png](https://github.com/wrf/genome-size/blob/master/images/refseq_proks_w_elliott2015_genome_size_vs_gene_size_v1.png)

![refseq_proks_w_elliott2015_genome_size_vs_gene_count_v1.png](https://github.com/wrf/genome-size/blob/master/images/refseq_proks_w_elliott2015_genome_size_vs_gene_count_v1.png)

This rule breaks down for eukaryotes, particularly the plants and animals. Larger proteins (hence larger genes) are much more common in eukaryotes, due to protein/domain fusions or repeated domains. The bulk of much larger genes, however, is junk in the form of introns. The largest human protein, [titin](https://www.ncbi.nlm.nih.gov/gene/7273) (281kb of 365 exons), is not the largest gene, which is instead [dystrophin](https://www.ncbi.nlm.nih.gov/gene/1756) (2Mb of 89 exons). The [dystrophin protein](https://www.uniprot.org/uniprot/P11532) is almost 10x smaller than the [titin protein](https://www.uniprot.org/uniprot/Q8WZ42), but the gene is 10x larger. Below, the spike in human proteins at ~300-350AAs is due to [olfactory receptors](https://www.uniprot.org/uniprot/?query=olfactory%20receptor&fil=reviewed%3Ayes+AND+organism%3A%22Homo+sapiens+%28Human%29+%5B9606%5D%22&sort=score).

![comparative_protein_size_plot_v1.png](https://github.com/wrf/genome-size/blob/master/images/comparative_protein_size_plot_v1.png)

The largest bacterial genomes in this set are [Sorangium cellulosum](https://www.ncbi.nlm.nih.gov/assembly/GCF_000067165.1) of 13.0Mb and [Ktedonobacter racemifer](https://www.ncbi.nlm.nih.gov/assembly/GCF_000178855.1) of 13.6Mb. This is substantially larger than the largest currently assembled archaeal genome, [Haloterrigena turkmenica](https://www.ncbi.nlm.nih.gov/assembly/GCF_000025325.1) of 5.4Mb. Nonetheless, both domains follow the gene-genome size scaling rule. Due to the single copy of the genome and absence of recombination mechanisms for most prokaryotes, the genome size would be determined by an equilibrium of gene addition (by HGT or duplication) and streamlining by stochastic gene loss. There are not many mechanisms of creating totally new genes (with respect to any given genome), either duplication and subsequent diversification, or possibly [frameshifting an existing protein](https://doi.org/10.1073/pnas.81.8.2421). As the average gene size is also around 1kb for nearly all prokaryotes, this also suggests that few genes result from fusion of other genes.

For reasons of saving the energetic cost of replication, transcription, and protein synthesis, the advantage of a reduced genome is clear. A stable environment therefore is likely to lead to streamlining ([Bentkowski 2015](https://doi.org/10.1093/gbe/evv148)). Conversely, this would imply that an unstable environment (rapidly changing across multiple time scales of environmental conditions, energy sources, or interaction partners) leads to genome expansion, by addition and retention of genes and pathways.

![prok_genome_streamline_scheme_v1.png](https://github.com/wrf/genome-size/blob/master/images/prok_genome_streamline_scheme_v1.png)

Eukaryotes on the other hand appear free from this constraint. While, at the moment, it does not appear that single-celled eukaryotes follow any such rule, it is clear that multicellular plants and animals have no correlation between genome size and gene number. Diploidy probably plays a role in this, as it becomes increasingly difficult to remove genes from a population, meaning that the stochastic removal (random) of a gene from a population would become fixed more from drift (also random) than selection by energetics.

## overview of animal genome sizes ##
This plot was based on data downloaded from the [Animal Genome Size Database](http://www.genomesize.com/), and plotted with the Rscript [animal_genome_size_overview_v1.R](https://github.com/wrf/genome-size/blob/master/animal_genome_size_overview_v1.R). Birds and mammals appear quite constrained in their genome sizes, though perhaps the same would be seen if the other phyla-level plots were restricted to subgroups.

![animalgenomes_combined_animals_v1.png](https://github.com/wrf/genome-size/blob/master/images/animalgenomes_combined_animals_v1.png)

## repeat content ##
A barplot of repeats in the human genome was based on data from [repeatmasker.org](http://repeatmasker.org/species/hg.html). This was preprocessed with the python script [repeatmasker_to_summary.py](https://github.com/wrf/genome-size/blob/master/repeatmasker_to_summary.py) and then plotted with the associated Rscript [make_repeatmasker_barplot.R](https://github.com/wrf/genome-size/blob/master/make_repeatmasker_barplot.R).

![human_GRCh38.repeat_top_10_barplot.png](https://github.com/wrf/genome-size/blob/master/images/human_GRCh38.repeat_top_10_barplot.png)

## reannotations of genomes ##
Some other analyses made use of data from the paper:

Francis, W.R. and G. Worheide (2017) [Similar ratios of introns to intergenic sequence across animal genomes](https://academic.oup.com/gbe/article-lookup/doi/10.1093/gbe/evx103) *Genome Biology and Evolution* 9 (6): 1582-1598.

In this paper, I had shown a similar ratio of introns to intergenic sequence in a few dozen animal genomes, suggesting that the processes that shape intronic and intergenic fractions are likely similar. This has been extended to many more species, now including many chromosome-level assemblies. All raw data ([for re-anaylsis or figures](https://bitbucket.org/wrf/genome-reannotations/src)) and re-annotations ([both GFF and protein](https://bitbucket.org/wrf/genome-reannotations/downloads)) can be found at the [associated bitbucket repository](https://bitbucket.org/wrf/genome-reannotations/overview)

There are a few unresolved questions with this result. The first is the consideration of the role of time in evolution. As prokaryotes do not have introns, the "original" eukaryote would have been intronless, but nonetheless had intergenic regions (single digit percent). After the symbiosis event, introns were introduced, probably from genes from the symbiont. This easily could have resutled in a genome with *more* intronic bases than intergenic, meaning that the ratio of intron:intergenic went from 0:1, up to maybe 10:1, and then had to stabilize at some point.

The second issue is dealing with the number of introns versus the number of intergenic blocks. The *number* of bases is the same, though the number of blocks is tenfold higher for introns (depending on eukaryotic species). Again, this suggests that it is the [number of bases that matters, and not the number of blocks](https://github.com/wrf/misc-analyses/tree/master/intron_evolution).

