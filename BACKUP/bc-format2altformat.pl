#!/bin/perl

# As of 9 Mar 2015, I bunzip2 files before zpaq'ing them, so need only
# mtime and then filename (w/ .bz2 removed) to see what's already
# backed up

# my devnos:

# 2080 = /mnt/extdrive
# 64768 = /
# 234881026 = /mnt/sshfs3/
# 234881029 = /mnt/sshfs/
# 2886150081 = /mnt/sshfs2/c/
# 3154434839 = /mnt/sshfs2/k/

require "/usr/local/lib/bclib.pl";

while (<>) {

  my($mtime,$size,$inode,$perm,$type,$gname,$uname,$devno,$name) = 
    split(/\s+/, $_, 9);

  # recognized types I want to ignore
  if ($type=~/^[dspcb]$/) {next;}

  # ignore nonfiles/links
  unless ($type=~/^[fl]$/) {warn "BAD TYPE: $_"; next;}

  # edit filename based on devno
  if ($devno == 64768) {
    # do nothing, but not an error
  } elsif ($devno == 234881026) {
    $name = "/mnt/sshfs3$name";
  } elsif ($devno == 234881029) {
    $name=~s%/Volumes/[A-Z]{5}/%/mnt/sshfs/%;
  } elsif ($devno == 2886150081 || $devno == 3154434839) {
    $name=~s%/cygdrive/%/mnt/sshfs2/%;
  } else {
    warn("BAD DEVNO: $_");
    next;
  }

  # remove .bz2 if any (perhaps remove .gz later)
  $name=~s/\.bz2$//;

  # pad mtime to 10 characters so numerical sort == standard sort
  # (this is useful so I don't have to sort twice when using comm)
  # <h>this may break in 2286 AD or so </h>
  $mtime = sprintf("%0.10d", $mtime);
  print "$mtime $name";
}
