#!/usr/bin/env perl6

use v6;

sub process_template($template, %parameters) {
	my $processed = $template;

	for %parameters.keys -> $key {
		if %parameters{$key} {
			$processed.=subst('{'~$key~'}', %parameters{$key});
		}
	}
	
	return $processed;
}


sub create_rp($rpfile) {
	my @rp;

	for $rpfile.IO.lines -> $line {
		if $line.trim().chars() > 0 && !$line.starts-with('#') && $line.split('=').elems > 1 && $line.split('=')[1].trim().chars() > 0 {
			@rp = @rp.append($line);
		}
	}

	return @rp;
}


sub create_map(@rp) {
	my %mrp;

	for @rp -> $p {
		my @split_values = $p.split('=');
		if @split_values.elems == 2 {
			%mrp{@split_values[0]} = @split_values[1];
		}
	}

	return %mrp;
}


sub MAIN(:$urifile!, :$rpfile = 'request_parameters.txt') {
	my @uri = $urifile.IO.lines;
	my @rp = create_rp($rpfile);
	my %mrp = create_map(@rp);

	say @rp;

	for @uri -> $u {
		my $processed = process_template($u, %mrp);
		my $uri_full = $processed~'?'~@rp.join('&');

		say $uri_full;
	}
}

