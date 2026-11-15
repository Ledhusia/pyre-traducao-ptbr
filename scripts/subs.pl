#!/usr/bin/perl
# Legendas das cutscenes (Content/Subtitles/es/*.csv).
#   perl scripts/subs.pl extract  -> work/Subtitles/src/chunk_NNN.txt (a partir de work/Subtitles/orig)
#   perl scripts/subs.pl check    -> compara códigos {..} do ES com o PT
#   perl scripts/subs.pl build    -> out/Subtitles/es/*.csv
use strict; use warnings; use utf8;
use FindBin; use lib $FindBin::Bin; use common;
binmode STDOUT, ':utf8';

my $R = root();
my $W = "$R/work/Subtitles";
my @FILES = qw(Justice Match);
my $PER = 40;

sub split_csv {    # retorna campos brutos (com aspas), preservando o texto original
    my ($l) = @_;
    my @f; my $cur = ''; my $inq = 0;
    for my $c (split //, $l) {
        if ($c eq '"') { $inq = !$inq; $cur .= $c; }
        elsif ($c eq ',' && !$inq) { push @f, $cur; $cur = ''; }
        else { $cur .= $c; }
    }
    push @f, $cur;
    return @f;
}
sub unq { my $s = shift; if ($s =~ /^"(.*)"$/s) { $s = $1; $s =~ s/""/"/g; } return $s; }
sub enq { my $s = shift; return ($s =~ /[",]/) ? '"' . ($s =~ s/"/""/gr) . '"' : $s; }

sub rows {    # [ [idx, tipo, id, linha_ES] ... ]
    my ($path) = @_;
    my ($lines) = read_lines($path);
    my @r;
    for my $i (0 .. $#$lines) {
        my @f = split_csv($lines->[$i]);
        next unless @f >= 5 && ($f[0] eq 'Integrated' || $f[0] eq 'Greg');
        my $t = unq($f[4]);
        next unless $t =~ /\S/;
        push @r, [$i, $f[0], $f[1], $t];
    }
    return @r;
}
sub tok { my $s = shift; my @t = ($s =~ /(\{[^{}]*\})/g); return join ' ', sort @t; }

sub read_pt {
    my %pt;
    for my $f (glob "$W/pt/chunk_*.txt") {
        my ($ls) = read_lines($f);
        for (@$ls) { next unless /^([A-Za-z]+_\d+[a-z]*)\|(.*)$/; $pt{$1} = $2; }
    }
    return %pt;
}

my $mode = shift // '';
if ($mode eq 'extract') {
    my %en;
    for my $n (@FILES) { $en{$_->[2]} = $_->[3] for rows("$W/orig/en/$n.csv"); }
    my @all = map { rows("$W/orig/es/$_.csv") } @FILES;
    mkdir "$W/src"; mkdir "$W/pt";
    my $k = 0;
    while (my @b = splice @all, 0, $PER) {
        $k++;
        my @o;
        push @o, "#$_->[2]", "EN: " . ($en{$_->[2]} // ''), "ES: $_->[3]" for @b;
        write_lines(sprintf("$W/src/chunk_%03d.txt", $k), [@o, ''], 0, "\n");
    }
    print "$k lotes\n";
} elsif ($mode eq 'check') {
    my %pt = read_pt();
    my ($ok, $bad, $tot) = (0, 0, 0);
    for my $n (@FILES) {
        for my $r (rows("$W/orig/es/$n.csv")) {
            $tot++;
            next unless exists $pt{$r->[2]};
            my $p = $pt{$r->[2]};
            if (tok($p) ne tok($r->[3]) || $p =~ /"/) { $bad++; print "$r->[2]: códigos diferentes\n    ES: ", tok($r->[3]), "\n    PT: ", tok($p), "\n"; }
            else { $ok++; }
        }
    }
    printf "Subtitles: %d ok, %d com problema; progresso %d/%d (%.1f%%)\n", $ok, $bad, $ok + $bad, $tot, 100 * ($ok + $bad) / $tot;
} elsif ($mode eq 'build') {
    my %pt = read_pt();
    mkdir "$R/out/Subtitles"; mkdir "$R/out/Subtitles/es";
    for my $n (@FILES) {
        my ($lines, $bom, $eol) = read_lines("$W/orig/es/$n.csv");
        my ($done, $miss) = (0, 0);
        for my $r (rows("$W/orig/es/$n.csv")) {
            my @f = split_csv($lines->[$r->[0]]);
            if (exists $pt{$r->[2]}) { $f[4] = enq(fonte_jogo($pt{$r->[2]})); $lines->[$r->[0]] = join ',', @f; $done++; }
            else { $miss++; }
        }
        write_lines("$R/out/Subtitles/es/$n.csv", $lines, $bom, $eol);
        print "$n: $done traduzidas, $miss sem tradução -> out/Subtitles/es/$n.csv\n";
    }
} else { die "uso: subs.pl extract|check|build\n"; }
