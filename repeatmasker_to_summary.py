#!/usr/bin/env python

# repeatmasker_to_summary.py  created 2020-01-05

'''
repeatmasker_to_summary.py hg38.fa.out.gz > hg38.fa.repeatmasker_output_summary.tab

    input can be .gz
    example based on data from:
    http://repeatmasker.org/species/hg.html

  generates 4-column summary table consisting of:
repeatclass    number    total bases    percent of total
'''

#   SW  perc perc perc  query      position in query           matching       repeat              position in  repeat
#score  div. del. ins.  sequence    begin     end    (left)    repeat         class/family         begin  end (left)   ID

#  463   1.3  0.6  1.7  chr1        10001   10468 (248945954) +  (TAACCC)n      Simple_repeat            1  463    (0)      1
# 4005  11.3 21.5  1.3  chr1        10469   11447 (248944975) C  TAR1           Satellite/telo       (399) 1712    483      2
#  535  21.2 15.9  3.1  chr1        11485   11676 (248944746) C  L1MC5a         LINE/L1              (510) 5667   5447      3
#  263  29.4  1.9  1.0  chr1        11678   11780 (248944642) C  MER5B          DNA/hAT-Charlie       (74)  104      1      4
#  309  23.0  3.7  0.0  chr1        15265   15355 (248941067) C  MIR3           SINE/MIR             (119)  143     49      5
#   18  23.2  0.0  2.0  chr1        15798   15849 (248940573) +  (TGCTCC)n      Simple_repeat            1   51    (0)      6
#  255  28.9 20.5  0.0  chr1        16363   16459 (248939963) C  Charlie15a     DNA/hAT-Charlie      (101)  123      2      7
#   18  13.7  0.0  0.0  chr1        16713   16744 (248939678) +  (TGG)n         Simple_repeat            1   32    (0)      8
#  225  33.8 12.9  0.0  chr1        18907   19048 (248937374) +  L2a            LINE/L2               2942 3104  (322)      9



import sys
import gzip
import time
import os

if len(sys.argv)<2:
	sys.exit( __doc__ )
else:
	chr_sizes = {} # key is chr, value is length as int
	category_counts = {} # key is repeat class, value is count
	category_sums = {} # key is repeat class, value is sum of lengths

	repeatmaskerfile = sys.argv[1]

	if repeatmaskerfile.rsplit('.',1)[-1]=="gz": # autodetect gzip format
		opentype = gzip.open
		sys.stderr.write("# Reading repeats from {} as gzipped  ".format(repeatmaskerfile) + time.asctime() + os.linesep)
	else: # otherwise assume normal open for fasta format
		opentype = open
		sys.stderr.write("# Reading repeats from {}  ".format(repeatmaskerfile) + time.asctime() + os.linesep)

	linecounter = 0
	for line in opentype(repeatmaskerfile,'rt'):
		line = line.strip()
		if line:
			lsplits = line.split()
#    0     1    2    3     4            5       6           7 8  9              10
#  972  31.2  6.0  2.5  chr1        19972   20405 (248936017) +  L3             LINE/CR1              2680 3129  (970)     10
			if lsplits[0]=="SW" or lsplits[0]=="score":
				continue
			linecounter += 1
			scaffold = lsplits[4]
			sstart = int(lsplits[5])
			send = int(lsplits[6])
			sleft = int( lsplits[7].replace("(","").replace(")","") ) + send
			repclass = lsplits[10]
			category_counts[repclass] = category_counts.get(repclass,0) + 1
			chr_sizes[scaffold] = sleft
			replen = send - sstart + 1 # offset 1 for base notation
			category_sums[repclass] = category_sums.get(repclass, 0) + replen
	sys.stderr.write("# Counted {} lines  ".format( linecounter ) + time.asctime() + os.linesep)
	genomesum = sum(chr_sizes.values())
	repeatsum = sum(category_sums.values())
	sys.stderr.write("# Repeats are {} bases out of {} ({:.2f}%)\n".format( repeatsum, genomesum, repeatsum*100.0/genomesum ))
	for k,v in category_sums.items():
		sys.stdout.write("{}\t{}\t{}\t{:.2f}\n".format(k,category_counts.get(k,0),v,v*100.0/genomesum) )
	sys.stdout.write("unmasked\t0\t{}\t{:.2f}\n".format( genomesum-repeatsum, (genomesum-repeatsum)*100.0/genomesum) )










