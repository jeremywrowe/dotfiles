export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"
plugins=(mix git zsh-autosuggestions heroku)
source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$HOME/man:$MANPATH"

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.npm-global/bin"

[ -f "$HOME/.private" ] && source "$HOME/.private"

GPG1_DIR=$(brew --prefix gpg1)/libexec/gpgbin
if [ -d "${GPG1_DIR}" ]; then
  export PATH="${GPG1_DIR}:${PATH}"
fi

export BUNDLE_JOBS=8
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export RACK_ATTACK_ENABLED=1
export RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)"

export GPG_TTY=$(tty)
export RPROMPT='%(1j.%j.)'

alias dot="vim $HOME/bin/\$(ls -1 "$HOME/bin" | fzf)"
alias e="$EDITOR"
alias ls="ls -G"
alias mux="tmuxinator"
alias reload="source $HOME/.zshrc"
alias puma-logs="tail -f ~/Library/Logs/puma-dev.log"
alias dcom="docker-compose"

p () {
  local directory="$(tree /Volumes/Source/* -L 1 -d -f -i | fzf)"
  if [[ $directory ]]; then
    cd $directory
  fi
}

set -o emacs

[ -f "$HOME/.private" ] && source "$HOME/.private"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Find fuzzies
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use vim cli mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Add autocomplete from homebrew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Grab github token for bundler

export BUNDLE_GITHUB__COM="$(cat ~/.config/hub|grep token | awk '{ print $2 }')"

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
unsetopt beep

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

eval "$(rbenv init -)"
