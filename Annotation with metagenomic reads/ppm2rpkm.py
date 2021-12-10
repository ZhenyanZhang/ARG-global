import os
import sys


ppm_file = sys.argv[1]
gene_len_file = sys.argv[2]

gene_dict = {}
f = open(gene_len_file)
lines = f.readlines()
for line in lines:
	line = line.strip()
	if line:
		data = line.split('\t')
		gene_dict[data[0]] = data[1]
f.close()


f = open(ppm_file)
lines = f.readlines()
for line in lines[1:]:
	line = line.strip()
	if line:
		data = line.split('\t')
		gene = data[1]
		ppm = data[2]
		gene_len = float(gene_dict[gene])
		rpkm = float(ppm)*1000/gene_len
		print(line+'\t'+str(rpkm))
f.close()