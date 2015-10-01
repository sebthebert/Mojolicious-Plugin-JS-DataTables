#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojolicious::Static;

plugin 'JS::DataTables';

my $static = Mojolicious::Static->new;
push @{$static->paths}, 'public';

get '/' => sub 
{
	my $self = shift;
	$self->render('demo');
};

get '/json' => sub 
{
	my $self = shift;

	my $json = $static->file('json/sample.json')->slurp;
	$self->render(text => $json);
};

app->start;

__DATA__

@@ demo.html.ep
% layout 'default';
% title 'Mojolicious::Plugin::JS::DataTables demo';

<h1>DataTables demo</h1>

<h2>Simple DataTable</h2>

<%= datatables 
	id => 'mojoliciousplugin', 
	class => 'table table-striped table-bordered',
	ajax => 'json',
	col_headers => 'Name,Position';
%>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
    <head>
    <title><%= title %></title>
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.9/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.9/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </head>
    <body>
    <%= content %>
    </body>
</html>
