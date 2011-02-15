# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="xoebus"
export CASE_SENSITIVE="true"
plugins=( git osx brew ruby textmate gem lighthouse pip )
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/Users/cb/Developer/bin/gdircolors:/usr/local/Cellar/python/2.7.1/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/local/bin:$PATH:~/.bin:~/.at-tools/bin
export NODE_PATH="/usr/local/lib/node"
export EDITOR="mvim"
export NXJ_HOME=/Users/cb/lejos_nxj
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/Home
export PATH=$PATH:$JAVA_HOME/bin:$NXJ_HOME/bin
export DYLD_LIBRARY_PATH=$NXJ_HOME/bin
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/System/Library/Frameworks/JavaVM.framework/Headers

# $ gh-get https://github.com/defunkt/facebox/blob/master/src/facebox.js
function gh-get () {
  curl --progress-bar -O $(echo $1 | sed 's|blob|raw|')
}


# ALIASES
# torrent move
alias load-torrent="mv ~/Downloads/*.torrent /Volumes/Icarus/Torrent/watch"
alias open-media="open /Volumes/Icarus/Media/"
alias open-torrent="open /Volumes/Icarus/Torrent/"

alias pgp="gpg"

alias v="mvim"
alias vs="mvim --remote-silent"
alias vt="mvim --remote-tab-silent"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"

alias nudge="sed 's/^/    /'"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"

alias playing="osascript -e 'tell application \"iTunes\" to if player state is playing then name of current track & \" - \" & artist of current track'"

alias vless="vim -u /usr/share/vim/vim72/macros/less.vim"

# FUNCTIONS
# sleep the mac
function sleep-mac() {osascript -e 'tell app "finder" to sleep'}
# hub -> git
function git() {nocorrect noglob hub "$@"}
# ron -> ronn
function ron() {ronn "$@"}

# file encryption
function encrypt() {gpg -ao $3 -esr $1 $2}
function decrypt() {gpg -o $2 -d $1}

# basic text translation
function translate() { wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1/'; }

# get public IP of this computer
function ip() {curl icanhazip.com}

# get futurama quote
function futurama() {curl -Is slashdot.org | egrep '^X-(F|B|L|H)' | cut -d \- -f 2}

# upgrade brew-packges 
function brew-upgrade() {brew update && brew list | xargs brew install}

# sprunge.us pasting
function sprunge() { cat $1 | curl -F "sprunge=<-" http://sprunge.us | awk '{sub(/^[ \t]+/, "")};1' | pbcopy; pbpaste }

# check x-code projects
function clang-gen() { rm -rf /tmp/scan-build*; xcodebuild clean; /Developer/Tools/clang/scan-build --view xcodebuild }

# create a new essay
function new-essay() {
	git clone git://github.com/xoebus/essay-template.git $1
	cd $1
	rm -rf .git
	git init -g
	git add .
	git ci -m "Initial commit"
	rake init
}

#autojump
#Copyright Joel Schaerer 2008, 2009
#This file is part of autojump

#autojump is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#autojump is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with autojump.  If not, see <http://www.gnu.org/licenses/>.

#local data_dir=${XDG_DATA_HOME:-$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)}
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

#test -e "$HOME/.dircolors" && COLORS="$HOME/.dircolors" && eval `gdircolors $COLORS`

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
