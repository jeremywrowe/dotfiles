export DEPLOY_AS=jeremyro

export MANPATH="/usr/local/man:$HOME/man:$MANPATH"

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.cargo/env"

export BUNDLE_JOBS=8
export EDITOR="code --wait"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export RACK_ATTACK_ENABLED=1
export RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)"
export GPG_TTY=$(tty)
export BUNDLE_GITHUB__COM="$(cat ~/.config/hub|grep token | awk '{ print $2 }')"

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f "$HOME/.private" ] && source "$HOME/.private"

GPG1_DIR=$(brew --prefix gpg1)/libexec/gpgbin
if [ -d "${GPG1_DIR}" ]; then
  export PATH="${GPG1_DIR}:${PATH}"
fi

alias dot="vim $HOME/bin/\$(ls -1 "$HOME/bin" | fzf)"
alias e="$EDITOR"
alias ls="ls -G"
alias mux="tmuxinator"
alias reload="source $HOME/.zshrc"
alias puma-logs="tail -f ~/Library/Logs/puma-dev.log"
alias dcom="docker-compose"
alias l="colorls -al"

function n () {
  local directory="$(tree /Volumes/Source/* -L 1 -d -f -i | fzf)"
  if [[ $directory ]]; then
    cd $directory
  fi
}

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

eval "$(rbenv init -)"

COLOR_GIT_CLEAN='\[\033[1;30m\]'
COLOR_GIT_MODIFIED='\[\033[0;33m\]'
COLOR_GIT_STAGED='\[\033[0;36m\]'
COLOR_RESET='\[\033[0m\]'

function git_prompt() {
	if [ -e ".git" ]; then
		branch_name=$(git symbolic-ref -q HEAD)
		branch_name=${branch_name##refs/heads/}
		branch_name=${branch_name:-HEAD}

		echo -n "→ "

		if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
			echo -n "$COLOR_GIT_CLEAN$branch_name$COLOR_RESET"
		elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
			echo -n "$COLOR_GIT_STAGED$branch_name$COLOR_RESET"
		else
			echo -n "$COLOR_GIT_MODIFIED$branch_name*$COLOR_RESET"
		fi

		echo -n " "
	fi
}

function prompt() {
	PS1="\u@\h [ \w $(git_prompt)] \$ "
}

PROMPT_COMMAND=prompt
source "$HOME/.cargo/env"
