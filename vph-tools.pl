#!/usr/bin/perl -w

use strict;

use LWP::Simple;
my @urls;
@urls = map {"http://toolkit.vph-noe.eu/home/tools/page_$_.html"} (2..16);
unshift(@urls, "http://toolkit.vph-noe.eu/home/tools.html");

foreach my $url (@urls) {
    my $content = get($url);
    while ($content =~ /title_vc" href="([^"]+)".*?>([^<]+)/sg) {
        print("$1 : $2\n");
    }
}
