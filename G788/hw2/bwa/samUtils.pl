#!usr/bin/perl 
use warnings;

#analysis sam files, report #reads mapped, coverage, etc

if ($#ARGV[0] < 0)
{
	print "usage:perl program samFile\n";
	exit();
}
my $infile = $ARGV[0];
my @line = ();
my $genomeSize = 0;
my $coverage = 0;
my $readlen = 0;
my $mappedReads = 0;
my %lendis = ();#read length distribution

open (IN,"$infile")||die "$!";
while(<IN>)
{
	s/\s+$//;
	if (/^@/)
	{
		@line = split(/\s+/,$_);
		$genomeSize += $line[$#line];
	}
	else
	{
		@line = split(/\t/,$_);
		if ($line[6] ne '*')
		{
			$mappedReads ++;
			$readlen += length($line[]);
			$lendis{length($line[])} += 1;
		}
	}

}
close IN;


$coverage = $readlen / $genomeSize;
print "#mapped reads:\t$mapped\ncoverage:\t$coverage\n";
foreach my $ll (keys %lendis)
{
	print "$ll\t$lendis{$ll}\n";
}








