#!/usr/bin/perl
# Uso: perl extract.pl <Arquivo> [itens_por_lote]
# Gera work/<Arquivo>/strings.tsv e lotes work/<Arquivo>/src/chunk_NNN.txt
# com cada texto único do espanhol (e o inglês correspondente como referência).
use strict; use warnings; use utf8;
use FindBin; use lib $FindBin::Bin; use common;
use File::Path qw(make_path);
binmode STDOUT, ':utf8';

my $file = shift or die "uso: extract.pl <1_Keywords|Events|HelpText> [tamanho]\n";
my $max_chars = shift || 9000;
my $R = root();
my ($es, $order) = read_entries("$R/original/$file.es.xml");
my ($en) = read_entries("$R/original/$file.en.xml");

my (%idx, @str, @enref, @auto);
for my $id (@$order) {
    for my $a (ATTRS) {
        my $v = $es->{$id}{$a}; next unless defined $v;
        next if exists $idx{$v};
        $idx{$v} = scalar @str;
        push @str, $v;
        my $e = $en->{$id}{$a}; $e = '' unless defined $e;
        push @enref, $e;
        # Sem letras fora dos códigos {...}: não precisa traduzir.
        (my $bare = $v) =~ s/\{[^{}]*\}//g; $bare =~ s/\\n//g;
        push @auto, ($bare =~ /\p{L}/ ? 0 : 1);
    }
}

my $W = "$R/work/$file";
make_path("$W/src", "$W/pt");
open my $t, '>:utf8', "$W/strings.tsv" or die;
print $t join("\t", $_, $auto[$_], $str[$_]), "\n" for 0..$#str;
close $t;

my ($n, $size, $fh) = (0, 1e9, undef);
my $todo = 0;
for my $i (0..$#str) {
    next if $auto[$i];
    $todo++;
    if ($size > $max_chars) {
        close $fh if $fh;
        $n++; $size = 0;
        open $fh, '>:utf8', sprintf("$W/src/chunk_%03d.txt", $n) or die;
    }
    print $fh "#$i\nEN: $enref[$i]\nES: $str[$i]\n";
    $size += length($str[$i]) + length($enref[$i]);
}
close $fh if $fh;
printf "%s: %d textos únicos, %d para traduzir, %d automáticos, %d lotes\n",
    $file, scalar @str, $todo, scalar(grep {$_} @auto), $n;
