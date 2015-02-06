#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Not needed, global xinitrc already does this
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

# Execute the global xinitrc file
if [ -f /etc/X11/xinit/xinitrc ]; then
    . /etc/X11/xinit/xinitrc
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# Keymap and other options
xkbcomp -I$HOME/.xkb ~/.xkb/keymaps/mv_custom $DISPLAY

# Make the mouse left-handed (i.e. discourage mouse use!)
xinput set-button-map 16  3 2 1 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24

# Set desktop bg
feh --bg-fill ~/Desktop/HAL9000.jpg &
#xsetroot -solid red
exec dbus-launch i3
