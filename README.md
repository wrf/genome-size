# genome-size #
examination of genome size and content across the tree of life

## relationship of genome size vs gene count ##
There is a rather strict relationship of genome size to gene count among prokaryotes, of approximately 1000bp per gene. This rule breaks down for eukaryotes, particularly the plants and animals.

Prokaryotic genome data from refseq assembly stats and feature counts were downloaded from [NCBI Assembly](https://www.ncbi.nlm.nih.gov/assembly/). This included both the "Assembly Statistics Report" and the "Feature Counts Report", for both archaea and bacteria. The data of each assembly and annotation was then combined using the python script [aggregate_size_and_features.py](https://github.com/wrf/genome-size/blob/master/aggregate_size_and_features.py).

Eukaryotic genome data were reported in the supplement of [Elliott 2015 What's in a genome? The C-value enigma and the evolution of eukaryotic genome content](https://doi.org/10.1098/rstb.2014.0331).

![refseq_proks_w_elliott2015_genome_size_vs_gene_count_v1.png](https://github.com/wrf/genome-size/blob/master/images/refseq_proks_w_elliott2015_genome_size_vs_gene_count_v1.png)

## overview of animal genome sizes ##
This plot was based on data downloaded from the [Animal Genome Size Database](http://www.genomesize.com/), and plotted with the Rscript [animal_genome_size_overview_v1.R](https://github.com/wrf/genome-size/blob/master/animal_genome_size_overview_v1.R).

![animalgenomes_combined_animals_v1.png](https://github.com/wrf/genome-size/blob/master/images/animalgenomes_combined_animals_v1.png)

## repeat content ##
A barplot of repeats in the human genome was based on data from [repeatmasker.org](http://repeatmasker.org/species/hg.html). This was preprocessed with the python script [repeatmasker_to_summary.py](https://github.com/wrf/genome-size/blob/master/repeatmasker_to_summary.py) and then plotted with the associated Rscript [make_repeatmasker_barplot.R](https://github.com/wrf/genome-size/blob/master/make_repeatmasker_barplot.R).

![human_GRCh38.repeat_top_10_barplot.png](https://github.com/wrf/genome-size/blob/master/images/human_GRCh38.repeat_top_10_barplot.png)

## reannotations of genomes ##
Some other analyses made use of data from the paper:

Francis, W.R. and G. Worheide (2017) [Similar ratios of introns to intergenic sequence across animal genomes](https://academic.oup.com/gbe/article-lookup/doi/10.1093/gbe/evx103) *Genome Biology and Evolution* 9 (6): 1582-1598.

All raw data ([for re-anaylsis or figures](https://bitbucket.org/wrf/genome-reannotations/src)) and re-annotations ([both GFF and protein](https://bitbucket.org/wrf/genome-reannotations/downloads)) can be found at the [bitbucket repository of the same name](https://bitbucket.org/wrf/genome-reannotations/overview)

