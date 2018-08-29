use Data::Dumper;
use strict;
my %h;
my $count=0;
my $scaffold;
my $pos;
my $depth;
my $init;
open (F, $ARGV[0]);
while (<F>){
	chomp;
	unless (exists ($h{$scaffold})){
		$count=0;
	}
	my @line=split ("\t",$_);
	my $scaffold=$line[0];
	my $pos=$line[1];
	my $depth=$line[2];
	$h{$scaffold}{'count'}+=$depth;
	$h{$scaffold}{'pos'}=$pos;
}
#print Dumper \%h;

foreach my $k (keys %h){
	$pos=$h{$k}{'pos'};
	$count=$h{$k}{'count'};
	if ($count!=0 && $pos!=0){
		my $average=$count/$pos;
		print "$k:$average\n";
	}
	else {
		print "$k: no average because pos=0";
	}
}
