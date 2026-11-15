#!/usr/bin/perl
# Uso: perl build.pl <Arquivo>
# Monta out/<Arquivo>.es.xml a partir do espanhol original, trocando cada texto
# pela tradução em work/<Arquivo>/pt/*.txt (linhas "índice<TAB>texto").
# Textos ainda sem tradução usam o inglês do mesmo Id (ou o espanhol, se não houver).
use strict; use warnings; use utf8;
use FindBin; use lib $FindBin::Bin; use common;
use File::Path qw(make_path);
binmode STDOUT, ':utf8';

my $file = shift or die "uso: build.pl <Arquivo>\n";
my $R = root(); my $W = "$R/work/$file";
my (%idx, @auto);
open my $t, '<:utf8', "$W/strings.tsv" or die "rode extract.pl antes\n";
while (<$t>) { chomp; my ($i, $a, $s) = split /\t/, $_, 3; $idx{$s} = $i; $auto[$i] = $a; }
close $t;

my %pt = load_pt($W);
my ($en) = read_entries("$R/original/$file.en.xml");
my ($lines, $bom, $eol) = read_lines("$R/original/$file.es.xml");
my ($tr, $fb_en, $fb_es) = (0, 0, 0);
for my $l (@$lines) {
    next unless $l =~ /<Text\s/ && $l =~ /\sId="([^"]*)"/;
    my $id = $1;
    for my $a (ATTRS) {
        next unless $l =~ /\s$a="([^"]*)"/;
        my $v = $1; my $i = $idx{$v};
        my $new;
        if (exists $pt{"\@$id.$a"})           { $new = $pt{"\@$id.$a"}; $tr++; }
        elsif (defined $i && $auto[$i])       { next; }
        elsif (defined $i && exists $pt{$i})  { $new = $pt{$i}; $tr++; }
        elsif (defined $en->{$id}{$a})        { $new = $en->{$id}{$a}; $fb_en++; }
        else                                  { $fb_es++; next; }
        $l =~ s/(\s$a=")[^"]*(")/$1$new$2/;
    }
}
make_path("$R/out");
write_lines("$R/out/$file.es.xml", $lines, $bom, $eol);
print "$file: $tr traduzidos, $fb_en em inglês, $fb_es em espanhol -> out/$file.es.xml\n";

sub load_pt {
    my ($W) = @_; my %h;
    for my $f (sort glob("$W/pt/*.txt")) {
        open my $fh, '<:utf8', $f or die;
        while (<$fh>) {
            s/\r?\n$//;
            # "índice|texto" ou, para um Id específico, "@Id.Atributo|texto"
            next unless /^(\d+|\@[^|\t]+)[\t|](.*)$/;
            $h{$1} = $2;
        }
    }
    return %h;
}
