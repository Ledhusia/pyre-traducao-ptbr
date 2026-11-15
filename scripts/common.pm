package common;
# Funções compartilhadas pelos scripts de tradução do Pyre.
use strict; use warnings; use utf8;
use Exporter 'import';
our @EXPORT = qw(read_entries tokens root ATTRS read_lines write_lines fonte_jogo);

# A fonte do jogo não tem alguns caracteres (aparecem como "*"): troca na saída.
sub fonte_jogo { my $s = shift; $s =~ tr/õÕ/oO/; return $s; }

use constant ATTRS => qw(DisplayName Description AdditionalDescription);

sub root { require FindBin; my $d = $FindBin::Bin; $d =~ s{[\\/]scripts$}{}; return $d; }

sub read_lines {
    my ($path) = @_;
    open my $fh, '<:raw', $path or die "não abriu $path: $!";
    local $/; my $raw = <$fh>; close $fh;
    my $bom = ($raw =~ s/^\xEF\xBB\xBF//) ? 1 : 0;
    utf8::decode($raw) or die "UTF-8 inválido em $path";
    my $eol = ($raw =~ /\r\n/) ? "\r\n" : "\n";
    my @lines = split /\r?\n/, $raw, -1;
    return (\@lines, $bom, $eol);
}

sub write_lines {
    my ($path, $lines, $bom, $eol) = @_;
    my $out = join($eol, @$lines);
    utf8::encode($out);
    open my $fh, '>:raw', $path or die "não gravou $path: $!";
    print $fh "\xEF\xBB\xBF" if $bom;
    print $fh $out; close $fh;
}

# Lê um arquivo de texto do jogo: retorna { Id => { attr => valor_bruto } } e ordem dos Ids.
sub read_entries {
    my ($path) = @_;
    my ($lines) = read_lines($path);
    my $all = join ' ', @$lines;
    $all =~ s/<!--.*?-->//gs;
    my (%e, @order);
    for my $l ($all =~ /(<Text\s[^>]*>)/g) {
        next unless $l =~ /\sId="([^"]*)"/;
        my $id = $1;
        push @order, $id unless exists $e{$id};
        for my $a (ATTRS) { $e{$id}{$a} = $1 if $l =~ /\s$a="([^"]*)"/; }
    }
    return (\%e, \@order);
}

# Códigos que precisam ser preservados: {...} e o \n literal.
sub tokens {
    my ($s) = @_;
    my @t = ($s =~ /(\{[^{}]*\})/g);
    my $n = () = $s =~ /\\n/g;
    push @t, ('\n') x $n;
    return sort @t;
}
1;
