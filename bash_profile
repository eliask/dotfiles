# -*- shell-script -*-
umask 077
date
screen -list 2>/dev/null
. ~/.bashrc

# This eliminates the need for .bash_logout. Clears the screen if using tty:
if tty | grep '^/dev/tty[0-9]\+$' >/dev/null; then
    [ -x /usr/bin/clear_console ] && trap '/usr/bin/clear_console -q' EXIT
fi
