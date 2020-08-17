use Time::Local;
use POSIX qw(ceil floor strftime);
$esw=0.5;


#open OUT, ">AquaCrop/DATA/Optim.IRR";
open OUT, ">C:/_Schlag_die_KI/AquaCrop/DATA/Optim.IRR";

@IRR=@ARGV;
$irr_sum=0;
foreach $wert (@IRR) {
$irr_sum=$irr_sum+$wert;
#print "$wert\n";
}
$irr_sum=$irr_sum; #Addition der gesetzten Menge fuer Anfang
#print "Bewässerungsmenge: $irr_sum\n";


print OUT "Irrigation doses for T1 from Transplanting to last harvest.\n";
print OUT "   4.0   : AquaCrop Version (June 2012)\n";
print OUT "   5     : Drip irrigation\n";
print OUT "  30     : Percentage of soil surface wetted by irrigation\n";
print OUT "   1     : Irrigation schedule\n";
print OUT "\n";
print OUT "   Day    Depth (mm)   ECw (dS/m)\n";
print OUT "====================================\n";

$tag=10;

foreach $wert (@IRR) { 
if ($wert>0) {
print OUT "   $tag         $wert         $esw\n";
}
$tag=$tag+10; 
 }