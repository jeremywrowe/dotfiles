eval "$(starship init zsh)"

autoload -Uz compinit
compinit

export MANPATH="/usr/local/man:$HOME/man:$MANPATH"

export GOPATH="/Volumes/Source/go-deps:/Volumes/Source/go"
export GOBIN="/Volumes/Source/go/bin"

export PATH="/usr/local/opt/gnupg@1.4/libexec/gpgbin:$PATH"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.cargo/env"
export PATH="$PATH:$GOBIN"

[ -d "$HOME/bin-private" ] && export PATH="$PATH:$HOME/bin-private"
[ -f "$HOME/.private" ] && source "$HOME/.private"

export BUNDLE_JOBS=8
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export RACK_ATTACK_ENABLED=1
export RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)"
export BAT_THEME="Solarized (light)"

export GPG_TTY=$(tty)

p () {
  local directory="$(tree /Volumes/Source/* -L 1 -d -f -i | fzf)"
  if [[ $directory ]]; then
    cd $directory
  fi
}

set -o emacs

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
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
  export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
unsetopt beep

. $HOME/.asdf/asdf.sh
