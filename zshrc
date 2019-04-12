autoload -U promptinit; promptinit
prompt pure

eval "$(rbenv init -)"

export MANPATH="/usr/local/man:$HOME/man:$MANPATH"

export PATH="$PATH:$HOME/.rbenv/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/.cargo/bin"

[ -f "$HOME/.private" ] && source "$HOME/.private"

GPG1_DIR=$(brew --prefix gpg1)/libexec/gpgbin
if [ -d "${GPG1_DIR}" ]; then
  export PATH="${GPG1_DIR}:${PATH}"
fi

export EDITOR="vim"
export BUNDLE_JOBS=8
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export RACK_ATTACK_ENABLED=1

export GPG_TTY=$(tty)
export RPROMPT='%(1j.%j.)'


alias e="$EDITOR"
alias p="cd \$(tree /Volumes/Source/* -L 1 -d -f -i | fzf)"
alias ls="ls -G"
alias dot="vim $HOME/bin/\$(ls -1 "$HOME/bin" | fzf)"
alias reload="source $HOME/.zshrc"

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
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob
unsetopt beep
