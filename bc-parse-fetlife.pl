#!/bin/perl

# parses a fetlife user page

require "/usr/local/lib/bclib.pl";

# fixed random seed (we need predictability while testing)
srand(20140321);

@files = glob("/home/barrycarter/20140321/user*.html");

for $i (randomize(\@files)) {
  # read the file
  $all = read_file($i);

  # if the title is identically "Home - FetLife", something went wrong
  $all=~s%<title>(.*?)</title>%%s;
  $title = $1;
  if ($title eq "Home - FetLife") {next;}

  # user number is only in filename
  $i=~/\/user(\d+)\.html$/;
  ($user) = $1;

  # name and orientation/gender
  $all=~s%<h2 class="bottom">(.*?)\s*<span class="small quiet">(\d+)(.*)\s+(.*?)</span></h2>%%;
  ($name, $age, $gender, $role) = ($1, $2, $3, $4);

  # location data is first <p> in page, all one line
  $all=~s%<p>(.*?)</p>%%is;
  ($location) = $1;
  $location=~s/<.*?>//isg;
  # should really fix unicode more genrically, this works for n tilde only
  $location=~s/\xe2\x88\x9a\xc2\xb1/n/isg;
  debug($location);



#  debug("$user,$name,$age,$gender,$role");
}

die "TESTING";

# test file (not anyone I know)
$all = read_file("/home/barrycarter/20140321/user1861827.html");

# debug($all);

# name and orientation/gender
$all=~s%<h2 class="bottom">(.*?)</h2>%%s;
$val{extra} = $1;

# table fields with headers/colons
while ($all=~s%<tr>\s*<th[^>]*>(.*?)</th>\s*<td>(.*?)</td>\s*</tr>%%is) {
  $val{$1} = $2;
}

# latest activity (useful to see when user was last active)
$all=~s%<h3 class="bottom">Latest activity</h3>(.*?)<h3 class="bottom">Fetishes </h3>(.*?)%%;

debug("VAL",%val);


die "TESTING";

# kinkster (user) name
$all=~s%<title>(.*?)\s+\-\s*kinksters\s*\-\s*fetlife</title>%%is || warn("NO NAME: $all");



debug($1);