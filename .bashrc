
export PATH="$PATH:~/src/utils/fasd"
eval "$(fasd --init auto)"

alias l='ls --color'
alias n='ls -ltc|head'
alias c='cd'
alias p='pwd'
alias v='vim'
alias e='emacs'
alias s='ssh'
alias q='pkg search'
alias i='pkg install'
alias g='grep'
unalias a
a() {
  local app=$(launch -l | 
	  grep -v [A-Z] |
	  fzf -q "$@" -1 -0 --no-sort +m --history=$HOME/.launch_history)
  [ -n "$app" ] && launch $app
}
. "${EXTERNAL_STORAGE}/termuxlauncher/.apps-launcher"
command -v launch >/dev/null &&
 complete -W "$(launch -l|g -v [A-Z])" launch a

alias j='e -f zw-goto-now'

sp() { sshpass -f ~/creds/$1 ssh $@; }
export PATH="$PATH:/data/data/com.termux/files/home/buildAPKs/scripts/build"

alias work='sp pitt -t "~/private/sshpass-1.06/sshpass -f ~/meson.cred ssh -t m -t ssh reese"'

PS1='# \[\e[01;31m\]\t \[\e[01;32m\]\w\n\[\e[00m\] '


_f() { 
 local e=$1; shift
 local file 
 file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $e "${file}" || return 1;
 }

alias f="_f vim"   #"fasd -f -e vim"
alias F="_f emacs" #"fasd -f -e emacs"


# https://github.com/junegunn/fzf/wiki/examples#with-write-to-terminal-capabilities
bind '"\C-r": "\C-x1\e^\er"' 
bind -x '"\C-x1": __fzf_history'; 
__fzf_history () { __ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"'); } 

__ehc() { 
	if [[ -n $1 ]]; then 
		bind '"\er": redraw-current-line' 
		bind '"\e^": magic-space' 
		READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}} 
		READLINE_POINT=$(( READLINE_POINT + ${#1} )) 
	else 
		bind '"\er":' bind '"\e^":' 
	fi 
}
source /data/data/com.termux/files/home/src/utils/fuzzy_arg/fuzzy_arg.bash
