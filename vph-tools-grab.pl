#!/usr/bin/perl -w

use strict;

while (<>) {
    my ($url, $urlpart, $name) = m!(http://toolkit.vph-noe.eu/home/(\S+)) : (.*)!;
    my $cmd = "./grab.py $url pages/$urlpart";
    print($cmd . "\n");
    system($cmd);
    sleep(3);
}

