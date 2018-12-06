#!/usr/bin/python

import argparse
import sys
import os
import re


class Parser():

    def __init__(self):
        parser = argparse.ArgumentParser(
            description='Format gff file to bed',
            usage='''python3 gff2bed.py <command> [options]

Command:  exonextraction\textract exon info and write into bed file

'''
        )
        parser.add_argument('command', help='Command to run', nargs='?')
        args = parser.parse_args(sys.argv[1:2])
        if not args.command:
            print()
            parser.print_usage()
            print()
            exit(1)
        if not hasattr(self, args.command):
            print()
            parser.print_usage()
            print()
            exit(1)
        getattr(self, args.command)()

    def exonextraction(self):
        parser = argparse.ArgumentParser(
            description='Generates a matrix of haplotypes sex distribution',
            usage='''python3 gff2bed.py exonextraction -i input_file [-o output_file]

Options:  -i\t--input-file\tPath to a gff file
\t  -o\t--output-file\tPath to output file (default: exon.bed)
''')
        parser.add_argument('--input-file', '-i',
                            help='Path to a gff file')
        parser.add_argument('--output-file', '-o',
                            help='Path to output file', nargs='?',
                            default='exon.bed')
        args = parser.parse_args(sys.argv[2:])
        if not args.input_file or not os.path.isfile(args.input_file):
            print('\nError: no valid input file specified\n')
            parser.print_usage()
            print()
            exit(1)
        analysis(input_file_path=args.input_file,
                 output_file_path=args.output_file)


def analysis(input_file_path, output_file_path):
    gff = open(input_file_path, 'r')
    bed = open(output_file_path, 'w')
    n = 0
    for line in gff:
        if not line.startswith('#'):
            info = re.search(r'(?P<chr>NC_.*?)\s+.*?\s+(?P<region>.*?)\s+(?P<startpos>\d+)\s+(?P<endpos>\d+).*;gene=(?P<genes>.*?);.*', line)
            if info:
                # print('yes')
                if info.group('region') == 'exon':
                    chromosome = info.group('chr')
                    # print(chromosome)
                    exon = info.group('region')
                    # print(exon)
                    startpos = info.group('startpos')
                    # print(startpos)
                    endpos = info.group('endpos')
                    # print(endpos)
                    gene = info.group('genes')
                    # print(gene)
                    bed.write(chromosome + '\t' + startpos + '\t' + endpos + '\t' + exon + '\t' + gene + '\n')
            else:
                n += 1
                print(str(n) + ' lines not matched')
                pass


Parser()
