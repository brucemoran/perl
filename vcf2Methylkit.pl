#! /usr/bin/perl;

use strict;
use warnings;

#make cpg.VCF from BisSNP into methylKit format:

open(IN,$ARGV[0]);
while(<IN>){
    chomp;
    if($_=~m/^#/){next;}
    my @F=split(/\t/,$_);
    my @s=split(/\:/,$F[-1]);
    my @s1=split(/\;/,$F[7]);
    my @s2=split(/\=/,$s1[0]);
    my$cov=$s[3]+$s[5];
    if($s[3]==0){
	print "$F[0].$F[1]\t$F[0]\t$F[1]\t$s2[1]\t$cov\t0\t1\n";next;
    }
    if($s[5]==0){
	print "$F[0].$F[1]\t$F[0]\t$F[1]\t$s2[1]\t$cov\t1\t0\n";next;
    }
    else{
	my $fc=$s[3]/$cov;
	my $fc1=substr($fc,0,7);
	my $ft=1-$fc1;
	print "$F[0].$F[1]\t$F[0]\t$F[1]\t$s2[1]\t$cov\t$fc1\t$ft\n";
    }
}
close IN;
exit;
