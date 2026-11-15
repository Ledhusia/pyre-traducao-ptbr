# Repara linhas com UTF-8 duplamente codificado (ex.: "vocÃª" -> "você").
use strict; use warnings; use Encode;
for my $f (@ARGV) {
    open my $in, '<:raw', $f or die; local $/; my $raw = <$in>; close $in;
    my $txt = decode('UTF-8', $raw);
    my $n = 0;
    $txt =~ s{^(.*\x{C3}.*)$}{ my $l=$1; my $b=eval{ encode('latin1',$l,1) }; my $d=defined $b ? eval{ decode('UTF-8',$b,1) } : undef; if(defined $d){$n++; $d}else{$l} }gme;
    open my $out, '>:raw', $f or die; print $out encode('UTF-8', $txt); close $out;
    print "$f: $n linhas reparadas\n";
}
