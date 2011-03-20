# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="xoebus"
export CASE_SENSITIVE="true"
plugins=( git osx brew ruby textmate gem lighthouse pip )
source $ZSH/oh-my-zsh.sh

# PATH Changes
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/Home
export NODE_PATH="/usr/local/lib/node"
export NXJ_HOME=/Users/cb/lejos_nxj
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$NXJ_HOME/bin
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/System/Library/Frameworks/JavaVM.framework/Headers

PATH=/usr/local/sbin:/usr/local/bin:$PATH
PATH=$PATH:~/.bin
PATH=$PATH:$JAVA_HOME/bin:$NXJ_HOME/bin
export PATH

# Global Changes
export EDITOR="mvim"

# ALIASES
# Editor 
alias v="mvim"
alias vs="mvim --remote-silent"
alias vt="mvim --remote-tab-silent"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vless="vim -u /usr/share/vim/vim72/macros/less.vim"

# Indent all lines from STDIN by 4 spaces.
#
#    pbpaste | nudge | pbcopy
#
alias nudge="sed 's/^/    /'"

# Show the name and artist og the currently playing track in iTunes.
#
alias playing="osascript -e 'tell application \"iTunes\" to if player state is playing then name of current track & \" - \" & artist of current track'"

# FUNCTIONS
# Download files from github.
#
#   gh-get <github-url>
#
function gh-get() {
  curl --progress-bar -O $(echo $1 | sed 's|blob|raw|')
}

# Hub is pretty awesome. We should use that.
function git() {
	nocorrect noglob hub "$@"
}

# Poke autossh into responding.
function wakeup-ssh {
	rm ~/.ssh/connections/connection-cb@nebula.void.li:9000
	pkill -s USR1 autossh
}

# Encrypt and decrypt files from the command line.
#
#    encrypt <recipient-email> <input> <output>
#    decrypt <input> <output>
#
function encrypt() {gpg -ao $3 -esr $1 $2}
function decrypt() {gpg -o $2 -d $1}

# Text Translation
#
#    translate <text> [<source language> <destination language>]
#
function translate() { wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1/'; }

# Public IP of this computer
function ip() {curl icanhazip.com}

# Futurama Quote
function futurama() {curl -Is slashdot.org | egrep '^X-(F|B|L|H)' | cut -d \- -f 2}

# Autojump
# Copyright Joel Schaerer 2008, 2009
# This file is part of autojump

# autojump is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# autojump is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with autojump.  If not, see <http://www.gnu.org/licenses/>.

local data_dir=$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)
if [[ "$data_dir" = "${HOME}" ]]
then
    export AUTOJUMP_DATA_DIR=${data_dir}
else
    export AUTOJUMP_DATA_DIR=${data_dir}/autojump
fi
if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
then
    mkdir "${AUTOJUMP_DATA_DIR}"
    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
fi

function autojump_preexec() {
    { (autojump -a "$(pwd -P)"&)>/dev/null 2>>|${AUTOJUMP_DATA_DIR}/.autojump_errors ; } 2>/dev/null
}

typeset -ga preexec_functions
preexec_functions+=autojump_preexec

alias jumpstat="autojump --stat"

function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";fi }

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
