$file=$ARGV[0];

#d#print $file,"\n";

open IN, "<$file";
open OUT, ">result.txt";

<IN>;<IN>;<IN>;<IN>;
while (<IN>)

{
@TABS=split;
$Zeile=join("\t",@TABS[1..$#TABS-1]);
#d# print OUT $Zeile,"\n";

}

print OUT $TABS[30],"\n";
close OUT;
close IN;