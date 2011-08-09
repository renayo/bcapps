#!/bin/perl

# Trivial wrapper around forex_quote(), intended to run from cron
# every 1m (even though it looks back 5m). Options:
# --until=yyyymmdd.hhmmss: don't run until yyyymmdd.hhmmss (lets me
# turn off alerts temporarily)

require "/home/barrycarter/BCGIT/bclib.pl";
$now = stardate(time());

if ($globopts{until} && $now < $globopts{until}) {exit(0);}

# my private email address (public one: barry at barrycarter dot info)
$email = read_file("/home/barrycarter/bc-email.txt");
chomp($email);

# obtain from args (parity format: USD/CAD)
($parity, $low, $high) = @ARGV;

@x=forex_quote($parity,time(),"list=true");

for $i (@x) {
  %hash = ();
  while ($i=~s%<(.*?)>(.*?)</\1>%%) {
    $hash{lc($1)} = $2;
  }

  debug("HASH",unfold(%hash));
  debug("$hash{bid} - $hash{offer}");

  # theoretically possible for both to be true, but not worth testing

  # my phone treats identical messages as a single msg, so being
  # careful below to ensure message is same for given high/low

  # TODO: separate out phone, regular email, and xmessage messages

  if ($hash{bid} < $low) {
    $msg = "BC FOREX ALERT: $parity < $low";
  } elsif ($hash{offer} > $high) {
    $msg = "BC FOREX ALERT: $parity > $high";
  } else {
    $msg = "";
  }

  # if there is a msg, display it + kill old messages to avoid clutter
  if ($msg) {
    system("pkill -f 'BC FOREX ALERT: $parity'");
    system("xmessage -geometry 1024 -nearmouse '$msg' &");
    sendmail("alert\@barrycarter.info", $email, "", $msg);
    # no need to check rest
    exit();
  }
}


