# -*- shell-script -*-
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
    # Shell is non-interactive.
    return
fi

test -n "$DEBUG" && set -x
test -f "$HOME/.bashrc.local" && . "$HOME/.bashrc.local"

[ -z "$DISPLAY" ] && DISPLAY=:0 # Set some display if unset

# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508650
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix Java for most tiling WMs

export PERL5LIB=~/.perl/lib/perl5
export PYTHONPATH=~/.python/lib
export PYTHONSTARTUP=~/.pythonrc
export GEM_HOME=~/.gems
export GEM_PATH=~/.gems:/usr/lib/ruby/gems1.8
export ECLIPSE_HOME=~/proj/eclipse

export INFOPATH=~/docs/info
# Actually take $INFOPATH into account
alias install-info="install-info --infopath=$INFOPATH"

export PATH=~/bin:~/.cabal/bin:~/plt/bin:"$GEM_HOME/bin":"${PYTHONPATH/lib/bin}":~/.perl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

[ -f /etc/bash_completion ] && . /etc/bash_completion

# Make less more friendly for non-text files. See lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# don't set CDPATH (like $PATH for cd), it breaks stuff (autojump is better anyway)
export HISTSIZE=$((2**14))
#export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups #erasedups for global elimination
export HISTIGNORE='l:[bf]g'
export HISTTIMEFORMAT='%F %T '
#export PROMPT_COMMAND="${PROMPT_COMMAND:-:} ; history -a"
export EDITOR=emacsclient
export VISUAL=$EDITOR
export ALTERNATE_EDITOR='emacs -nw'
export COLUMNS #some programs won't see this otherwise

# Some basic command aliases
alias c=cd #useful with a quirky keyboard
alias ,='cd ..'
alias ,,="cd ../.."
alias cp='cp -i'
alias d='du --si -s'
alias du1='du --si --max-depth=1 -b | sort -n'
function ds() { d -bc "$@" | sort -n; }
alias df='df --si'
alias f='find'
alias l='ls --si -Fh --color=auto'
alias la='l -A'
alias ll='l -l'
alias lla='l -lA'
alias lcol='l --color=yes'
alias lsd='lcol -d'
alias lx='l -X'
alias less='less -FRSX'
# Too shiny IIRC:
#type colordiff &>/dev/null && alias diff=colordiff

function h() { test $# = 0 && history || history | grep -i "$*"; }
alias g='grep --color=auto'
alias eg='egrep --color=auto'
alias G='grep -i'
if type ack-grep &>/dev/null; then
    alias ack='ack-grep'
fi

# Some sort-of-working hacks to extract URLs from HTML:
alias grep-href="perl -lne'print for/href=['\''\"]?(.+)[\"'\'']?>/gi'"
#alias grep-href="perl -lne'print for/href=['\''\"]?([^\"'\''>]+?)/gi'"
alias grep-href2wiki="perl -le'\$/=\"\";while(<>){while(/href=['\''\"]?([^\"'\''>]+).*?(\/)?>([^<]*)/gi){if(\$2){print\"[[\$1]]\"}else{print\"[[\$1|\$3]]\"}}}'"
alias grep-hsrc="perl -lne'print for/src=['\''\"]?([^\"'\''>]+)/gi'"

alias mv='mv -i'
alias rm='rm -i'
alias tail='tail -n20'
alias head='head -n20'
# Analogously, head -n-$N takes all _but_ the last N lines
function drop() { N=$1; shift; tail -n+$N "$@"; }
function nohup2() { nohup "$@" &> /dev/null < /dev/null; }
alias watch='watch -n 0.5'

function screen1() {
    if test "$TERM" = screen; then
        echo "NOTE: Using I for the escape key"
        sleep 2
	screen -e ^Ii "$@"
    else
	screen "$@"
    fi
}
alias S='screen1 -dAaRR' # Do The Right Thing invoking screen (IMO)

alias lock='xscreensaver-command -lock || gnome-screensaver-common -l || slock'

# Debian-related
alias aptitude='sudo aptitude'
alias install='aptitude install' #install(1) isn't generally used anyway..
alias remove='aptitude remove'
alias purge='aptitude purge'
alias update='aptitude update'
alias upgrade='aptitude dist-upgrade'
alias search='apt-cache search'
alias aptf='apt-file search'

# Only show the most relevant package information:
function show() { apt-cache show $* | egrep '^(Package|Section|Version|Description| |Tag)'; }
alias showf='apt-cache show'
alias u='update && upgrade && aptitude clean'

# use existing bash completion code for those
complete -o filenames -F _aptitude install install
complete -o filenames -F _aptitude remove remove
complete -o filenames -F _aptitude purge purge
complete -o filenames -F _apt_cache show show
complete -o filenames -F _apt_cache show showf

# file compression
alias gz='gzip -9'
alias bz='bzip2 -9'
alias tart='tar tvf'
alias tarx='tar xvf'
alias tarc='tar cvf -a'
alias 7zamax='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias 7zx="batch '7z x'"
alias 7zl="batch '7z l'"
alias unrarx="batch 'unrar x'"
# Display the file_id.diz file in zip files
function diz_() { unzip -c "$1" "$(unzip -l "$1" | grep -i file_id.diz | perl -lne'/:..\s+(.+)/;print$1')"; }
alias diz="batch diz_"

# etc
function tmp1() { mvsuffix "$1" /tmp/"$(basename "$1")"; }
alias tmp='batch tmp1'
alias null='cat >/dev/null'
alias bc='bc -ql'
alias confcat='sed -e "/^\(\t\| \)*#.*\|^\(\t\| \)*$/d" -e "s/\(.*\)#.*/\1/" "$@"'
alias nano="nano -w --smooth"
alias e='editor'
alias em='emacs -nw --debug-init'
alias check-emacs="emacs -q --eval '(condition-case err (progn (load \"~/.emacs\") (kill-emacs 0)) (error (kill-emacs 1)))'" #http://gist.github.com/265113
alias :r='source ~/.bashrc && xrdb -merge ~/.Xresources'
alias :e='e ~/.bashrc && :r'
alias :t='type'
alias x='exit'
alias zargs="tr '\n' '\0' | xargs -0"
alias randomsort="perl -e"\''@a=<>;while(@a){$e=int(rand(@a));print$a[$e];delete$a[$e]}'\'
function wg() {
    if which wget &>/dev/null; then
	`which wget` "$@"
    elif which curl &>/dev/null; then
	`which curl` -O "$@"
    fi
}
alias wgetcrawl='wget -U "" -rk -nc --no-parent'
alias awksum="awk '{a+=\$1}END{print a}'"

alias mp='mplayer'
alias mps='mplayer -shuffle'
alias mps0='mplayer -shuffle -loop 0'
alias mp0='mplayer -loop 0'
alias mp1='mplayer -speed 1.7'

# A sort of working way to download videolectures.net stuff (though
# it's more reliable to manually get the URL and use 'mms' or something).
function mms1() {
    url="${1/http/mms}"
    echo "Downloading: $url"
    mplayer -quiet -dumpstream -dumpfile "$(basename "$url")" "$url"
}
alias mms='batch mms1'
function videolectures1() {
    mms1 "$(curl "$1" | grep-href | G wmv | G -o 'mms[^\"]*')"
}
alias videolectures='batch videolectures1'

alias you=youtube
alias youm='youtubem'
alias youtube="batchp 'youtube-dl -wtq'"
alias youtubes="batch 'youtube-dl -wt'"
alias youtubem="batchp 'youtube-dl -mwtq'"

function audiopipe() {
    if type padsp &>/dev/null; then
        padsp "$@"
    elif type aoss &>/dev/null; then
        aoss "$@"
    else
        command "$@"
    fi
}
alias sid='audiopipe sidplay2'
alias mikmod='audiopipe mikmod'

alias iftop='iftop -B'
alias to='htop'
alias s='sudo -s'
function mod-reload() { sudo modprobe -r $@; sudo modprobe $@; }

## Interpreters
alias irb='irb --readline -r irb/completion'

# Execute C code from stdin
function c-repl() {
    local tmp=`mktemp`
    rlwrap gcc -xc - -o $tmp && $tmp
    rm -f $tmp
}

if ! type rlwrap &>/dev/null; then
    alias rlwrap=''
else
    function rlwrap() {
        echo ">>> rlwrap $@" >&2
        command rlwrap "$@"
    }
fi
# rlwrap various interpreters without readline support
for x in racket picolisp clojure sbcl clisp guile \
    node-repl swipl js
do eval "alias $x='rlwrap $x'"; done

# Make git invocation without arguments do something useful:
# http://news.ycombinator.com/item?id=2363519
git() {
    if [[ $# == '0' ]]; then
        command git status
    else
        case $1 in
            fuss) shift; command git rebase -i HEAD~"$1";;
            *) command git "$@";;
        esac
    fi
}

# http://news.ycombinator.com/item?id=2567123
alias gitcc='git commit -m "#-checkpoint-" --edit'

alias loopmount='sudo mount -o loop'
# Mount CD images to /mnt/lN for N=0,1,..
function loopmounts() {
    i=0
    for f in "$@"; do
	sudo mkdir -p /mnt/l$i
        loopmount "$1" /mnt/l$i
        i=$(($i+1))
    done
}

# A maybe kind of reasonable (and idiomatic) way to get
# command-line MIDI playback somehow...
if type fluidsynth &>/dev/null
then if test -d /usr/share/sounds/sf2
    then alias midi='fluidsynth -ni /usr/share/sounds/sf2/*'
    else alias midi='fluidsynth -ni ~/r/sf2/SBLive/*'
    fi
else alias midi='aplaymidi -p`aplaymidi -l|tail -n1|awk {print\$1}`'
fi

# command-line pastebin
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
# Given stdin words, outputs a wordle HTML file to stdout
alias wordle="curl -F 'text=<-' http://www.wordle.net/advanced"

# Sensible defaults that prevent hitting Yahoo's download limits
alias yahoo2mbox='yahoo2mbox --delay=10'

# Make surf work correctly with local files
function surf() {
    if [[ -f "$1" ]]; then
        command surf "file://$(realpath "$1")"
    else
        command surf "$1"
    fi
}

# usually we want the debug symbols when manually building a package
export DEB_BUILD_OPTIONS=nostrip
alias debug-deb='export DEB_BUILD_OPTIONS=debug,nostrip'

# Prepend lines with the argument
function pre() { sed -e "s#^#$*#"; }
# Additionally use only the apparent directory name for prepending
function pre-path() { pre "$(dirname "$*")/"; }

# batch "do stuff to a file" files...
function batch() {
    p="$1"
    shift
    for x in "$@"; do
        eval '$p "$x"' || echo "batch: '$p $x' returned $?" >&2
    done
}

function batchp() {
    p="$1"
    shift
    for x in "$@"; do
        eval '$p "$x"' &
    done
}

function batchl() {
    p="$*"
    while read x; do
        eval '$p "$x"' || echo "batch: '$p $x' returned $?" >&2
    done
}

# Build and install a cabal package locally
function haskell-build ()
{
  dir="$1"
  ( set -e # Fail early
    cd "$dir"
    runghc Setup.*hs configure --user --prefix="$HOME"/.cabal
    runghc -L. Setup.*hs build #-L. in case /lib symlinks are missing, etc.
    runghc Setup.*hs install
  )
}
alias hb='batch haskell-build'

function mvtest () {
    if ! test -f "$2"; then
        mv -i "$1" "$2"
        return $?
    fi

    if cmp "$1" "$2"; then
        echo "'$arg' and '$new' identical. Skipping..."
    else
        echo -n "Append a unique suffix [y] or do nothing [n]? "
        read -n1 ans; echo
        if test "$ans" = y; then
            f="$(mvsuffix "$1" "$2")"
            echo "Moved '$1' to '$f'"
        fi
    fi
}
# TODO: fix issues with tmp-ing multiple directories with the same name
function mvsuffix() {
    f="$2"; s=-1
    while true; do
        if ! test -f "$f"; then
            mv "$1" "$f"; echo "$f"; return
        fi
        s=$(($s+1))
        f="$2.$s"
    done
}

function pspdf1 () {
    f="$1"
    pdf="$(echo $f | perl -ne 's/\.ps/.pdf/;s/(\.gz)*$//')"
    if test -f "$pdf"; then
        tmp "$f"
        return
    elif file "$f" | grep gzip >/dev/null; then
        if ! gunzip "$f" >/dev/null; then
            mv "$f" "$f.gz"
            gunzip "$f.gz" || return 1
        fi
        f="${f/.gz/}"
    fi
    ps2pdf "$f" "$pdf" && tmp "$f"
}
alias pspdf='batch pspdf1'

alias pdf-append='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=out.pdf'

# pdfr: Assign PDFs informative named efficiently
# Usage: pdfr [pdf files]
#
# A candidate name is presented for each 'OCR-able' PDF
# Press 'y' to accept the given name,
# 'n' to skip the current file without making any changes,
# '+' to move on to the next candidate "line",
# '-' to move to backwards,
# 'e' to expand the candidate title,
# 'c' to contract the candidate title, and
# 'r' to manually rename the file in question.
#
# TODO: add PDF viewer support for non-machine readable PDFs and otherwise.
alias pdfr='batch "pdf-rename 1 1"'
function pdf-rename() {
    tail="$1"
    line="$2"
    arg="$3"
    new="$(pdftotext "$arg" - | head -n$line | tail -n$tail | \
         sed -e 's/\([A-Za-z]\)\([A-Za-z]\+\)/\U\1\L\2/g' \
             -e 's,/,-,g'           \
             -e 's/Of /of /g'       \
             -e 's/And /and /g'     \
             -e 's/To /to /g'       \
             -e 's/Ai/AI/g'         \
             -e 's/ﬁ\(.\)/fi\l\1/g' \
             -e 's/ﬂ\(.\)/fl\l\1/g' \
             -e 's/ﬀ\(.\)/ff\l\1/g' \
             -e 's///g'           \
             -e 's/\**$//g'         \
             -e 's/:/-/g'           \
          | perl -ne'chomp;print"$_ "' | sed -e 's/ $//').pdf"
    echo "Old: $arg"
    echo "New: $new"

    if echo $new | grep '^.pdf$' >/dev/null && \
	! pdftotext "$arg" - | head -n$(($line+10)) | \
	tail -n10 | grep -i '[a-z0-9]' >/dev/null
    then
        echo "Cannot extract text from '$arg'. Skipping file..."
        return 1
    fi

    read -n1 ans
    case "$ans" in
        y) mvtest "$arg" "$new" ;;
        +) pdf-rename $tail $(($line + 1)) "$arg" ;;
        -) pdf-rename $tail $(($line - 1)) "$arg" ;;
        r) echo -n "Rename to: "; read ans && mv -i "$arg" "$ans" ;;
        e) pdf-rename $(($tail + 1)) $(($line + 1)) "$arg" ;;
        c) pdf-rename $(($tail - 1)) $(($line - 1)) "$arg" ;;
    esac
}

# shorthand to Debian package documentation, tab-completed
function doc() { cd /usr/share/doc/$1 && l; }
_doc ()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W "$(ls /usr/share/doc/ 2>/dev/null)" -- $cur ) )
}
complete -F _doc -o filenames doc

# Make antirtf behave like antiword
function antirtf() { batch unrtf "$@" | html2text; }

# A quick (slow) and dirty prime number lister
function primes() { seq $1 | perl -pe'$_ x=(1x$_)!~/^(|.|(..+)\2+)$/'; }

# List the biggest files in a directory
function lss() { lcol -SsA "$@" | head -n $(( $LINES - $(wc -l <<< $PS1)-1 )); }

# nperms - Normalise file permissions
# Make files non-executable and files/dirs non-world writeable)
function nperms1() {
    find "$1" -exec chmod go=u-w {} +
    find "$1" -type f -exec chmod -x {} +
}
alias nperms='batch nperms1'

# ps aux with -H (tree visualisation), optional grepping, and non-truncated lines.
function p() {
    COLUMNS=100000 # Around the largest legal value (1M is not)
    test $# = 0 && ps aux -H || \
	(ps aux|head -n1;ps aux | grep -i "$@" | grep -v grep)
}

# ps ax with optional grepping and non-truncated lines
function px() {
    COLUMNS=100000
    test $# = 0 && ps ax || (ps ax|head -n1;ps ax | grep "$*")
}

function sss() { ssh -t "$@" "screen -dAaRR"; }
alias ss='ssh -XC $@'
function x11vnc-ssh() {
    ssh -L 5900:localhost:5900 "$1" \
	'x11vnc -localhost -nolookup -nopw -display :0';
}
complete -F _ssh sss x11vnc-ssh

# Rarely used:

alias linuxversion='curl http://www.kernel.org/kdist/finger_banner'
function hex2ip() { perl -e"for('$@'=~/(..)/g){push"'@a,hex}print join(".",@a),"\n"'; }
function base2tochr() { perl -leprint" $(sed -e 's/ //g;s/\(.\{8\}\)/chr(0b\1),/g')"; }
function lc() { test $# = 0 && tr '[A-Z]' '[a-z]' || echo "$@" | tr '[A-Z]' '[a-z]'; }
function rot13() { tr A-Za-z N-ZA-Mn-za-m; }
function deltadate { echo $(($(date +%s)-$(date --date "$@" +%s))); }
function findsize()  { find $@ -printf "%s\n"; echo; }
function findowner() { find $@ -printf "%u\n"; echo; }
function udevi() { udevinfo -a -p `udevinfo -q path -n "$1"`; }

function pkcs12export() {
    while test $# -gt 0; do
	openssl pkcs12 -nocerts -in "$1" -out "${1/.p12/_key.pem}"
	openssl pkcs12 -nokeys -clcerts -in "$1" -out "${1/.p12/_cert.pem}"
	openssl pkcs12 -nokeys -cacerts -in "$1" -out "${1/.p12/_ca.pem}"
	shift
    done
}

function spell {
    if type ispell &>/dev/null; then
	echo $@ | ispell -a
    elif type aspell &>/dev/null; then
	echo $@ | aspell -a
    else
	echo -e "${cred}ispell/aspell not found on the system${creset}"
    fi
}

# function doc2pdf() {
#     batch "openoffice -norestore -nofirststartwizard -nologo -headless -pt Cups-PDF"
# }
# Doesn't even work. Instead use:
# batchl "ooo2any.py --extension pdf --format writer_pdf_Export" < list-of-docs (?)
alias ooo-start='openoffice.org "-accept=socket,host=localhost,port=2002;urp;"'

#set -o noclobber # disallow > to existing files
set -o ignoreeof # CTRL-D won't close the shell
shopt -s extglob # [?*+@!](pattern-list)
shopt -s cdspell # handles ~one-character spelling mistakes
shopt -s cmdhist # puts multiline commands to bash history
shopt -s lithist # multiline cmds stored literally
shopt -s checkhash
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s histappend histreedit
shopt -s checkwinsize

# Update dotfiles
pushcfg(){(
    cd; tar czpfvh cfg.tar.gz $(echo $dot_files $shell_files)
    scp cfg.tar.gz $dotfiles_host
    rm -f cfg.tar.gz
)}

pullcfg(){(
    cd; rm -f cfg.tar.gz
    wg $dotfiles_url
    tarx cfg.tar.gz && rm -f cfg.tar.gz
    :r
)}

lastsession=~/.lastsession_local
# See if we need to pull config files (if we haven't done so in 2 weeks)
maybepull(){
    now=$(date -u +%s 2>/dev/null)
    if [[ ! "$now" =~ ^[0-9]+$ ]]; then
	echo -e "$cred ++ could not read date, dotfiles will not expire$creset"
    elif [ -f "$lastsession" ]; then
	last=$(cat "$lastsession")
	limit=$(( $now - 14*24*60*60 ))
	if [[ $last -lt $limit ]]; then
	    echo $now > "$lastsession"
	    echo -e "$cyellow ++ dotfiles may be out of date, pull? [yN]$creset"
	    read -n1 ans
	    if [[ "$ans" == "y" ]]; then
		pullcfg
	    fi
	fi
    fi
}

## Define the terminal colours (PS1, ls colours, etc.):
# Highlighting
creset="\[\e[0m\]"
cbold="\[\e[1m\]"
cunder="\[\e[4m\]"
cblink="\[\e[5m\]"

# Regular colors
cblack="\[\e[0;30m\]"
cred="\[\e[0;31m\]"
cgreen="\[\e[0;32m\]"
cyellow="\[\e[0;33m\]"
cblue="\[\e[0;34m\]"
cmagenta="\[\e[0;35m\]"
ccyan="\[\e[0;36m\]"
cwhite="\[\e[0;37m\]"

# Emphasised (bolded) colours
cbblack="\[\e[1;30m\]"
cbred="\[\e[1;31m\]"
cbgreen="\[\e[1;32m\]"
cbyellow="\[\e[1;33m\]"
cbblue="\[\e[1;34m\]"
cbmagenta="\[\e[1;35m\]"
cbcyan="\[\e[1;36m\]"
cbwhite="\[\e[1;37m\]"

# Background colors
cbgblack="\[\e[40m\]"
cbgred="\[\e[41m\]"
cbggreen="\[\e[42m\]"
cbgyellow="\[\e[43m\]"
cbgblue="\[\e[44m\]"
cbgmagenta="\[\e[45m\]"
cbgcyan="\[\e[46m\]"
cbgwhite="\[\e[47m\]"

export _PS1="$cbwhite\u""$cwhite-""$cbred\h""$cbgreen\w""$creset\\$ "
export PS2=' ' #useful for copying text from terminal
export PS4='$0:$LINENO+ '

# Return value visualisation for graphical terminals 
if [ "$TERM" = "linux" ]; then
    # Fallback for text-only terminals:
    RET_SUCC='' #"${cgreen}v$creset"
    RET_FAIL="${cbred}X$creset"
else
    RET_SUCC="$cgreen\342\234\223$creset"
    RET_FAIL="$cbred\342\234\227$creset"
fi
export PROMPT_COMMAND='RET=$?; if [[ $RET -eq 0 ]]; then export PS1="${RET_SUCC}${_PS1}"; else export PS1="${RET_FAIL}${_PS1}"; fi'

# Undecipherable read-only colour values...
export LS_COLORS="\
no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:\
bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00:\
\
*.tar=01;31:*.gz=01;31:*.bz2=01;31:*.tgz=01;31:*.tbz2=01;31:\
*.zip=01;31:*.rar=01;31:*.Z=01;31:*.jar=01;31:*.7z=01;31:*.arj=01;31:\
\
*.png=01;35:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:\
*.pcx=01;35:*.tif=01;35:*.tiff=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:\
*.xpm=01;35:*.pbm=01;35:*.pgm=01;35:*.xcf=01;35:\
\
*.avi=01;35:*.ogm=01;35:*.mov=01;35:*.mpv=01;35:*.mkv=01;35:\
*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:\
*.mpg=01;35:*.mpeg=01;35:*.mp2=01;35:*.mp3=01;35:*.mp4=01;35:*.flv=01;35:\
*.xwd=01;35:*.ogg=01;35:*.wav=01;35:*.flac=01;35:*.mid=33:\
*.torrent=33:*.dsc=33:\
*.bin=33:*.iso=33:*.cue=33:\
*.deb=01;31:*.rpm=01;31"

[[ -f ~/.bash-aliases ]] && . ~/.bash-aliases
[[ -f /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh
maybepull
