#!/usr/bin/perl -w

use strict;

my %tool;
my $html = join('', <>);

my ($head) = $html =~ m!<table[^>]+"myview"[^>]*>(.*?)</table>!s;

# drop span tags
$head =~ s!</?span[^>]*>!!sg;
# normalise space
$head =~ s!(&nbsp;|\s)+! !sg;
# drop script tags
$head =~ s!</?script[^>]*>!!sg;
$head =~ s!<\!.*?-->!!sg;

while ($head =~ m!<td>(?:Hot)?\s*([^:<]+):\s*(.*?)</td>!sg) {
    $tool{$1} = $2;
}

# strip html
foreach my $key (qw/License Categories Tags/) {
  if (exists $tool{$key}) {
    $tool{$key} =~ s!<[^>]+>!!sg;
  }
}

if (exists $tool{Submitter}) {
  $tool{Submitter} =~ s!This e-mail address.*?view it!!sg;
  ($tool{'Submitter name'}) = $tool{Submitter} =~ m!>(.*?)</a>!;
  ($tool{'Submitter url'}) = $tool{Submitter} =~ /href="([^"]+.html)"/;
  ($tool{'Submitter email'}) = $tool{Submitter} =~ /href="mailto:([^"]+)"/;
  delete $tool{Submitter};
}

if (exists $tool{'Supported platform'}) {
  $tool{'Supported platform'} =~ s!.*?title="(.+?)".*!$1!sg;
}

foreach my $key (sort keys %tool) {
    print("$key: $tool{$key}\n");
}
