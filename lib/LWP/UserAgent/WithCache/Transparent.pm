package LWP::UserAgent::WithCache::Transparent;
use strict;
use warnings;
our $VERSION = '0.01';
use LWP::UserAgent::WithCache;

sub import {
    my $class = shift;
    my %opt = @_;

    no warnings 'redefine';
    my $orignew = *LWP::UserAgent::new{CODE};
    *LWP::UserAgent::new = sub {
        my $class = shift;
        my $caller = caller(0);
        if ($caller eq 'LWP::UserAgent::WithCache') {
            $orignew->($class, @_);
        } else {
            LWP::UserAgent::WithCache->new(%opt, @_);
        }
    };
}

1;
__END__

=head1 NAME

LWP::UserAgent::WithCache::Transparent - cache the response

=head1 SYNOPSIS

    perl -MLWP::UserAgent::WithCache::Transparent your-script.pl

=head1 DESCRIPTION

Cache the response automatically.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom @*(#RJKLFHFSDLJF gmail.comE<gt>

=head1 SEE ALSO

L<LWP::UserAgent::WithCache>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
