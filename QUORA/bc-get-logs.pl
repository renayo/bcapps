#!/bin/perl

# attempts to efficiently obtain quora log entries, similar to how I
# download fetlife data (ie, using large single connections, not many
# small ones)

require "/usr/local/lib/bclib.pl";

# TODO: don't hardcode this (150M = as of 7 Jun 2016)
my($start) = 150000000-1;

# command I use to download log entries
my($cmd) = "curl --compress --socks4a 127.0.0.1:9050";


# dir where I store these
my($logdir) = "/home/barrycarter/QUORA/LOG";
dodie('chdir("$logdir")');

# the longest command line (it's actually bigger than this, but this
# is a safe value)
my($maxlen) = 100000;

# TODO: if some come out "blank", stop for n seconds

# total length so far (start with infinity to force command at start)
my($len) = +Infinity;

# TODO: not sure if writing to file is a good idea here
open(B,">cmds.sh");

# eternal loop
for (;;) {

  # TODO: should I increment a different var?
  $start++;
  $str = "-o $start.html https://www.quora.com/log/revision/$start ";

  if ($len <= $maxlen) {print B $str; next;}

  # length too long, so print new line
  $str = "\n$cmd $str";
  $len = length($str);
  print B $str;
}