#!/usr/bin/python

"""
A python script to join two files by the first column and
fill these missed data with 0 .
male_file => male_file coverage file
female_file => female_file coverage file
"""
import sys
from collections import defaultdict

male_file_path = sys.argv[1]
female_file_path = sys.argv[2]
joined_file_path = sys.argv[3]

male_file = open(male_file_path, 'r')
female_file = open(female_file_path, 'r')
joined_file = open(joined_file_path, 'w')

# to store the whole object from first column of these two file
data = defaultdict(lambda: {'male': 0, 'female': 0})

for line in male_file:
    line_split = line[:-1].split(":")
    if len(line_split) == 2:
        data[line_split[0]]['male'] = line_split[1]

for line in female_file:
    line_split = line[:-1].split(":")
    if len(line_split) == 2:
        data[line_split[0]]['female'] = line_split[1]

# join the two files
joined_file.write('contig_name' + '\t' + 'M_cov.' + '\t' + 'F_cov.' + '\n')
for contig, coverage in data.items():
    joined_file.write(contig + '\t' + coverage['male'] + '\t' + coverage['female'] + '\n')
