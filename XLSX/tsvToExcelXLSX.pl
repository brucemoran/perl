#! /usr/bin/perl;

use strict;
use warnings;
use Excel::Writer::XLSX;

##generic script to pass multiple text files to individual worksheets in a workbook, sheets named by file input name
##pass multiple files using @ARGV, input is always tab or comma-delimited, or at least parsed by these delimiters and written per cell as such
##last name in @ARGV is output name
my $outFile=pop @ARGV;
my $workbook=Excel::Writer::XLSX->new($outFile . ".xlsx");

foreach my $file (@ARGV){
    open(IN,$file) or die "Couldn't open $file!\n";
    my $a=0;
    ##allow to use any path, but names must not contain slash, dot etc.
    my @filex=split(/\//,$file);
    ##valid sheet names are 32 chars
    my $valid_file=substr($filex[-1],0,31);
    my $worksheet=$workbook->add_worksheet($valid_file);
    ##allow boldening of header line
    my $format = $workbook->add_format();
    $format->set_bold();

    while(<IN>){
        chomp;

        my @sp=split(/\t/,$_);
        my $sp_ref=\@sp;
        if($a == 0){
            $worksheet->write_row($a,0,$sp_ref,$format);
        }
        $worksheet->write_row($a,0,$sp_ref);
        $a++;
    }
    close IN;
}

exit;
