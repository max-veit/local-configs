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
zsh -c refresh_input_settings

# Set desktop bg
feh --bg-fill ~/Desktop/HAL9000.jpg &
#xsetroot -solid red
exec dbus-launch i3
