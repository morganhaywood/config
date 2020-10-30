# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/morgan.haywood/.zshrc'

autoload -Uz compinit
compinit -i
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# prompt
autoload -Uz promptinit
promptinit
setopt prompt_subst
## git status
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '💙'
zstyle ':vcs_info:*' unstagedstr '💜'
zstyle ':vcs_info:*' formats '%b%c%u'
zstyle ':vcs_info:*' actionformats '%b (%a)'
precmd() {
  vcs_info
}
gitstat() {
  if [[ -n ${vcs_info_msg_0_} ]]; then
    s=$( git status --porcelain )
    if [[ -n "$s" ]]; then
      ut=$( grep '??' <<< "$s" &>/dev/null && echo '💔' || echo '' )
      echo "%F{red}(${vcs_info_msg_0_}$ut)%f"
    else
      echo "%F{green}(${vcs_info_msg_0_})%f"
    fi
  fi
}
## End git status
## pwd - remove go dir structure
workdir() {
  awk -v HOME="$HOME" '{sub(HOME, "~");sub(/src\/github.com/, "...");sub(/MYOB-Technology/, "tech");sub(/myob-ops/, "ops");print}' <<< "$PWD"
}
## End pwd
## seasonal emoji
emoji() {
  m=$( date '+%m' )
  { [[ "$m" -ge 3 ]] && [[ "$m" -le 5 ]]; } && autumn
  { [[ "$m" -ge 6 ]] && [[ "$m" -le 8 ]]; } && winter
  { [[ "$m" -ge 9 ]] && [[ "$m" -le 11 ]]; } && spring
  { [[ "$m" -ge 12 ]] || [[ "$m" -le 2 ]]; } && summer
}
autumn() {
  n=$( date '+%s' )
  k=$(( n % 5 ))
  [[ "$k" -eq 0 ]] && echo "🍁"
  [[ "$k" -eq 1 ]] && echo "🍄"
  [[ "$k" -eq 2 ]] && echo "🍂"
  [[ "$k" -eq 3 ]] && echo "🌾"
  [[ "$k" -eq 4 ]] && echo "🐳"
}
winter() {
  n=$( date '+%s' )
  k=$(( n % 5 ))
  [[ "$k" -eq 0 ]] && echo "🍵"
  [[ "$k" -eq 1 ]] && echo "🍡"
  [[ "$k" -eq 2 ]] && echo "🌰"
  [[ "$k" -eq 3 ]] && echo "🎍"
  [[ "$k" -eq 4 ]] && echo "🐳"
}
spring() {
  n=$( date '+%s' )
  k=$(( n % 5 ))
  [[ "$k" -eq 0 ]] && echo "🌸"
  [[ "$k" -eq 1 ]] && echo "🌺"
  [[ "$k" -eq 2 ]] && echo "🍃"
  [[ "$k" -eq 3 ]] && echo "🎐"
  [[ "$k" -eq 4 ]] && echo "🐳"
}
summer() {
  n=$( date '+%s' )
  k=$(( n % 5 ))
  [[ "$k" -eq 0 ]] && echo "🌻"
  [[ "$k" -eq 1 ]] && echo "🔥"
  [[ "$k" -eq 2 ]] && echo "🍧"
  [[ "$k" -eq 3 ]] && echo "🎋"
  [[ "$k" -eq 4 ]] && echo "🐳"
}
## end seasonal emoji
PROMPT='%(?.$(emoji).🈲 %F{red}%?%f) $(workdir) $(gitstat) $ '
# End prompt

# Env
# tooling
export PATH="/usr/local/bin:$HOME/bin:$PATH"
# aws
export AWS_DEFAULT_REGION='ap-southeast-2'
# go setup
export GOPATH=$HOME/go:$HOME/repos
export PATH=$PATH:$(sed 's|:|/bin:|g' <<< $GOPATH)/bin
export GO111MODULE=on
export GOPRIVATE=""
# End env vars

# Aliases
# repos
alias cdr='cd ~/repos/src/github.com'
# other
alias kakc='kak -c $(kak -l)'
# End aliases
