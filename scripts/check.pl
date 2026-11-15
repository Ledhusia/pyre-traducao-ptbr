#!/usr/bin/perl
# Uso: perl check.pl <Arquivo>
# Confere cada tradução contra o texto espanhol de origem:
#  - mesmos códigos {...} (palavras interativas, nomes, ícones, botões) e mesma quantidade de \n
#  - nenhum caractere que quebre o XML (" < & soltos, tabulação)
#  - índices que não existem
use strict; use warnings; use utf8;
use FindBin; use lib $FindBin::Bin; use common;
binmode STDOUT, ':utf8';

my $file = shift or die "uso: check.pl <Arquivo>\n";
my $R = root(); my $W = "$R/work/$file";
my (@str, @auto);
open my $t, '<:utf8', "$W/strings.tsv" or die;
while (<$t>) { chomp; my ($i, $a, $s) = split /\t/, $_, 3; $str[$i] = $s; $auto[$i] = $a; }
close $t;

my ($ok, $bad, %seen) = (0, 0);
for my $f (sort glob("$W/pt/*.txt")) {
    (my $short = $f) =~ s{.*/}{};
    open my $fh, '<:utf8', $f or die;
    while (<$fh>) {
        s/\r?\n$//; next if /^\s*$/;
        my @err;
        next if /^\@[^|\t]+[\t|]/;   # traduções por Id (pronomes) — conferidas no build
        if (!/^(\d+)[\t|](.*)$/) { print "$short:$.: linha fora do formato\n"; $bad++; next; }
        my ($i, $p) = ($1, $2);
        if (!defined $str[$i]) { push @err, "índice inexistente" }
        else {
            my $a = join ' ', tokens($str[$i]); my $b = join ' ', tokens($p);
            push @err, "códigos diferentes\n    ES: $a\n    PT: $b" if $a ne $b;
            push @err, "tradução vazia" if $p !~ /\S/ && $str[$i] =~ /\S/;
        }
        push @err, 'aspas " soltas (use &quot;)' if $p =~ /"/;
        push @err, '< solto (use &lt;)' if $p =~ /</;
        push @err, '& solto' if $p =~ /&(?!(?:amp|lt|gt|quot|apos|#\d+|#x[0-9a-fA-F]+);)/;
        push @err, 'tabulação no texto' if $p =~ /\t/;
        push @err, 'acentos corrompidos (Ã...)' if $p =~ /\x{C3}[\x{80}-\x{BF}\x{A0}-\x{FF}]/ || $p =~ /[\x{80}-\x{9F}]/;
        push @err, "índice repetido (também em $seen{$i})" if $seen{$i};
        $seen{$i} = $short;
        if (@err) { $bad++; print "$short:$. #$i: $_\n" for @err; } else { $ok++; }
    }
}
my $todo = grep { !$auto[$_] } 0..$#str;
my $done = grep { !$auto[$_] && $seen{$_} } 0..$#str;
printf "%s: %d ok, %d com problema; progresso %d/%d (%.1f%%)\n",
    $file, $ok, $bad, $done, $todo, $todo ? 100*$done/$todo : 100;
exit($bad ? 1 : 0);
