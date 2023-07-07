#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Push Python packages
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2023
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use GitHub::Crud qw(:all);
use Pod::Markdown;
use feature qw(say current_sub);

makeDieConfess;

my $home     = q(/home/phil/people/ashley/python/packages/);                    # Local files
my $user     = q(philiprbrenan);                                                # User
my $repo     = q(relativePythonPackages);                                       # Store code here so it can be referenced from a browser
my $wf       = q(.github/workflows/main.yml);                                   # Work flow on Ubuntu
my $readMe   = fpe $home, qw(README md2);                                       # Read me

expandWellKnownWordsInMarkDownFile $readMe, fpe $home, qw(README md);

push my @files, searchDirectoryTreesForMatchingFiles($home, qw(.py .md .pl));   # Files to upload

for my $s(@files)                                                               # Upload each selected file
 {my $c = readFile($s);                                                         # Load file
  my $t = swapFilePrefix $s, $home;
  my $w = writeFileUsingSavedToken($user, $repo, $t, $c);
  lll "$w $s $t";
 }

if (1)                                                                          # Work flow on github
 {my $d = dateTimeStamp;

  my $y = <<"END";
# Test $d

name: Test

on:
  push:
    paths:
      - '**.pm'
      - '**pushToGitHub.pl'
      - '**.yml'

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout\@v3
      with:
        ref: 'main'

    - name: Relative call
      run:  python3 -m sound.formats.mp3

    - name: Error call
      if: \${{ always() }}
      run:  python3 sound/formats/mp3.py

    - name: Error call
      if: \${{ always() }}
      run:  (cd sound/formats; python3 mp3.py)
END

  my $f = writeFileUsingSavedToken $user, $repo, $wf, $y;                       # Upload workflow
  lll "Ubuntu work flow for $repo written to: $f";
 }
