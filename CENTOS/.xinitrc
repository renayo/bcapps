# this runs (automagically) whenever I start FVWM

# my screen size is 1024x768

# TODO: find a way to customize this without having to run xrandr,
# although
# http://askubuntu.com/questions/74808/how-do-i-force-a-resolution-of-1024x768
# suggests it's nontrivial

xrandr --size 1024x768

# TODO: once I start using brighton directly, no reason to allow VNC
# so turn this off

/usr/libexec/vino-server & 

# these can be set in xorg.conf but it's easier to do it this way
xset dpms off
xset r rate 250 25

# per
# http://unix.stackexchange.com/questions/39518/turn-off-beep-of-xorg
# there may not actually be an option for this in xorg.conf, so doing
# it here

xset b off

# not sure if the below should really be here or if I should start
# them manually...

# firefox
firefox&

# stickly digital xclock in lower right hand corner
# TODO: nanoseconds (%N doesn't work after -strftime)

xclock -norender -font -misc-fixed-bold-r-normal--14-130-75-75-c-70-iso8859-1 -padding 0 -digital -update 1 -strftime '%a %d %b %Y %H:%M:%S' -geometry 170x19+854+749 &

# pidgin
gaim -n &

# I run screen multiply (using "screen -m") and this brings up two
# xterms to run those screens in

# TODO: back when I ran rxvt instead, "-font x" yields an error but
# brings up the right font whereas not using "-font" brings up the
# "wrong" (for me font); figure out how to do this properly

xterm -geometry 80x53 +sb -bg gray45 -bd gray45 -T SCREEN -n SCREEN &
xterm -geometry 80x53 +sb -bg gray45 -bd gray45 -T "SCREEN II" -n "SCREEN II" &

# runs elinks in an extra wide rxvt to the right of the main fvwm screen

rxvt -geometry 165x52+1024+26 -font x -T ELINKS -n ELINKS -e elinks &

# it's useful to have an extra wide screen just above the main fvwm screen
rxvt -geometry 165x52+0+2339 -font x -T WIDESCREEN -n WIDESCREEN &

# vidalia, like Generalisimo Francisco Franco, is still dead :(

# The exec below replaces the xinit process (which is no longer
# necessary after the above) with the fvwm2 window manager-- I think

exec fvwm2
