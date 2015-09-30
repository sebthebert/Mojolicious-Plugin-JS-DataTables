package Mojolicious::Plugin::JS::DataTables;

=encoding utf8

=head1 NAME

Mojolicious::Plugin::JS::DataTables - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious 
  $self->plugin('JS::DataTables');

  # Mojolicious::Lite
  plugin 'JS::DataTables';

=head1 DESCRIPTION

L<Mojolicious::Plugin::JS::DataTables> is a L<Mojolicious> plugin.

=cut

use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

=head1 METHODS

L<Mojolicious::Plugin::JS::DataTables> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=cut

sub register 
{ 
	my ($self, $app) = @_;

	$app->helper(datatables => sub { datatables(@_) });	
}

=head2 datatables

=cut

sub datatables
{
	my %attr = @_ % 2 ? (value => shift, @_) : @_;

	my $thead = '';
	if (defined $attr{col_headers})
	{
		$thead = '<thead><tr>';
		foreach my $h (split(/\s*,\s*/, $attr{col_headers}))
		{
			$thead .= "<th>$h</th>";
		}
		$thead .= '</tr></thead>';
	}  
	my $html = 
		qq[ <div class="container">\n ] 
    	. qq[ <table id="$attr{id}" class="$attr{class}" cellspacing="0" width="100%">\n ]
		. "$thead\n"
		. qq[ </table>\n</div>\n ]
		. qq[ <script type="text/javascript" charset="utf-8">\n ]
		. '$(document).ready(function() '
		. qq[ { \$('#$attr{id}').DataTable( ]
		. qq[ { "ajax": "$attr{ajax}" } ]
        . '); } ); </script>';

	return (Mojo::ByteStream->new($html));	
}

1;

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut

=head1 AUTHOR

Sébastien Thébert <stt@onetool.pm>

=cut
