import os
import sys
import re
from Bio import SeqIO

if len(sys.argv)<7:
    print("python %s card_result genome_file output_dir IS_DB In_Tn_DB threads"%(sys.argv[0]))
card_result = sys.argv[1]
genome_file = sys.argv[2]
outdir = sys.argv[3]
IS_DB = sys.argv[4]
In_Tn_DB = sys.argv[5]
threads = sys.argv[6]

if not os.path.exists(outdir):
    os.mkdir(outdir)
    
up_down_file = os.path.join(outdir,"up_down_5kb.fasta")
with open(up_down_file,'w') as w:
    w.write('')
contig_dict = {}
for rec in SeqIO.parse(genome_file,'fasta'):
    desc = rec.id
    seq = str(rec.seq)
    contig_dict[desc] = seq
    
step = 5000
w = open(up_down_file,'a')
f = open(card_result)
lines = f.readlines()
for line in lines[1:]:
    line = line.strip()
    if line:
        data = line.split("\t")
        gene = data[8].replace(" ","_")
        orf_id1 = '_'.join(data[1].split('_')[:-1])
        orf_id2 = data[1]
        if orf_id1 in contig_dict:
            orf_id = orf_id1
        else:
            orf_id = orf_id2
        start = int(data[2])
        end = int(data[3])
        up_s = start-step
        if up_s<1:
            up_s=1
        down_e = end+step
        contig_seq = contig_dict[orf_id]
        up_seq = contig_seq[up_s:start]
        down_seq = contig_seq[end-1:down_e-1]
        if len(up_seq)>50:
            w.write('>up~'+gene+'~'+orf_id+'\n'+up_seq+'\n')
        if len(down_seq)>50:
            w.write('>down~'+gene+'~'+orf_id+'\n'+down_seq+'\n')
f.close()
w.close()

cmd = "blastn -perc_identity 80 -culling_limit 1 -evalue 1E-10 -query {} -db {} -num_threads {} -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen slen' -out {}/IS.blast.out".format(up_down_file,IS_DB,threads,outdir)
print(cmd)
os.system(cmd)
is_blast_result = os.path.join(outdir,"IS.blast.out")
is_result = os.path.join(outdir,"IS.xls")
with open(is_result,'w') as w:
    w.write('qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen slen'.replace(' ','\t')+'\tcov\n')
w = open(is_result,'a')
f = open(is_blast_result)
lines = f.readlines()
for line in lines:
    data = line.strip().split("\t")
    cov = round(abs(int(data[8])-int(data[9]))*100/float(data[-1]),3)
    if cov>=80:
        w.write(line.strip()+'\t'+str(cov)+'\n')
f.close()
w.close()

cmd = "diamond blastx -culling-overlap -p {} -q {} -d {} -f 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore slen --id 60 -o {}/intn.diamond.out".format(threads,up_down_file,In_Tn_DB,outdir)
print(cmd)
os.system(cmd)
intn_diamond_result = os.path.join(outdir,"intn.diamond.out")
intn_result = os.path.join(outdir,"intn.xls")
with open(intn_result,'w') as w:
    w.write('qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore slen'.replace(' ','\t')+'\tcov\n')
w = open(intn_result,'a')
f = open(intn_diamond_result)
lines = f.readlines()
for line in lines:
    data = line.strip().split("\t")
    cov = round(abs(int(data[8])-int(data[9]))*100/float(data[-1]),3)
    if cov>=60:
        w.write(line.strip()+'\t'+str(cov)+'\n')
f.close()
w.close()