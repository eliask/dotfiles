if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# -- start rip config -- #
RIPDIR=/Users/cb/.rip
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$PATH:$RIPDIR/active/bin"
export RIPDIR RUBYLIB PATH
# -- end rip config -- #

##
# Your previous /Users/cb/.bash_profile file was backed up as /Users/cb/.bash_profile.macports-saved_2011-04-09_at_19:44:07
##

# MacPorts Installer addition on 2011-04-09_at_19:44:07: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

