#!/usr/bin/env python
#
# aggregate_size_and_features.py

'''aggregate_size_and_features.py  last updated 2021-01-02

    aggregate size information and features counts from RefSeq
    to make an easily-plotted table of genome size vs. gene count

aggregate_size_and_features.py -a *assembly_stats.txt -f *feature_count.txt > assembly_w_features.tab

~/git/genome-size/aggregate_size_and_features.py -a assembly-stats-2019-12-12/*assembly_stats.txt -f feature-count-2019-12-12/*_feature_count.txt > bacteria_assembly_stats_2019-12-12_w_features.tab
'''

import sys
import argparse

# assembly stats and feature counts downloaded from NCBI Assembly
# https://www.ncbi.nlm.nih.gov/assembly/
# for example:
#
# for Archaea
# https://www.ncbi.nlm.nih.gov/assembly/?term=txid2157%5BOrganism%3Aexp%5D
# clicking on the "Download Assemblies" button
# selecting the "Assembly Statistics Report"
#
# produces a .tar file, including a folder of .txt files, one for each genome
# and a file report.txt, which states
text_report = '''HistoryId: NCID_1_30605502_130.14.18.97_5555_1576144714_2477331710_0MetA0_S_HStore
QueryKey: 16
ReleaseType: RefSeq
FileType: ASM_STATS
Flat: true

Query title: Search txid2157[Organism:exp] AND latest[filter] AND "representative genome"[filter] AND  ( all[filter] NOT "derived from surveillance project"[filter] AND all[filter] NOT anomalous[filter] )   Sort by: SORTORDER
Search results count: 257
Filtered out 1 entries that do not have the requested ReleaseType, or are suppressed.
Entries to download: 256

ASM_STATS files in archive: 256
Total size (bytes): 1090685
Total time: 6.38 seconds
'''
#

def count_features(featurefile):
	# 0         1       2               3                       4                   5          6
	# Feature	Class	Full Assembly	Assembly-unit accession	Assembly-unit name	Unique Ids	Placements
	#CDS	with_protein	GCF_900100385.1	GCF_900100384.1	Primary Assembly	3117	3119
	featuredict = {} # key is assembly accession, value is sum of relevant features
	featurecount = 0
	for line in open(featurefile,'r'):
		line = line.strip()
		if line and line[0]!="#":
			lsplits = line.split("\t")
			feature = lsplits[0]
			fclass = lsplits[1]
			accession = lsplits[2]
			if (feature=="CDS" and fclass=="with_protein") or feature=="rRNA" or feature=="tRNA":
				placements = int(lsplits[6])
				featurecount += placements
	featuredict[accession] = featurecount
	return featuredict

def get_assembly_stats(assemblyfile, countsdict):
	# Organism name:  Halovenus aranensis (euryarchaeotes)
	for line in open(assemblyfile,'r'):
		line = line.strip()
		if line:
			if line[0]=="#":
				if line.find("Organism")>1:
					species = line.split(":")[1].strip()
					species = species.replace("=","_").replace('"','').replace("[","").replace("]","").replace("'","")
				elif line.find("RefSeq assembly accession")>1:
					accession = line.split(":")[1].strip()
			else:
				# 0         1               2                   3               4           5
				# unit-name	molecule-name	molecule-type/loc	sequence-type	statistic	value
				lsplits = line.split("\t")
				unitname = lsplits[0]
				molname = lsplits[1]
				seqtype = lsplits[3]
				if unitname=="Primary Assembly" and molname=="all" and seqtype=="all":
					statistic = lsplits[4]
					if statistic=="total-length":
						basecount = lsplits[5]
	genecount = countsdict[accession]
	outline = "{}\t{}\t{}\t{}\n".format( accession, species, basecount, genecount )
	sys.stdout.write(outline)
	# no return

def main(argv, wayout):
	if not len(argv):
		argv.append("-h")
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-a','--assembly-stats', nargs='*', help="assembly stats files")
	parser.add_argument('-f','--feature-counts', nargs='*', help="feature counts files")
	args = parser.parse_args(argv)

	featurecounts = {}
	sys.stderr.write("# Reading features for {} files\n".format( len(args.feature_counts) ) )
	for featurefile in args.feature_counts:
		featurecounts.update( count_features(featurefile) )
	sys.stderr.write("# Counted features for {} assemblies\n".format( len(featurecounts) ) )

	sys.stderr.write("# Reading assembly size for {} files\n".format( len(args.assembly_stats) ) )
	for assemblyfile in args.assembly_stats:
		get_assembly_stats(assemblyfile, featurecounts)

if __name__ == "__main__":
	main(sys.argv[1:],sys.stdout)
