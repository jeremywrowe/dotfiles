set PATH $HOME/.asdf/shims $PATH
set PATH /usr/local/sbin $PATH
set PATH /usr/local/bin $PATH
set PATH $HOME/.npm-global/bin $PATH
set PATH $HOME/bin $PATH
set PATH /Applications/Visual Studio Code.app/Contents/Resources/app/bin $PATH
set PATH $HOME/.cargo/bin $PATH

set -g -x GPG1_DIR (printf "%s/%s" (brew --prefix gpg1) "libexec/gpgbin")
if test -d $GPG1_DIR
  set -g -x PATH $GPG1_DIR $PATH
end

set -g -x BUNDLE_JOBS 8
set -g -x EDITOR code
set -g -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -g -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -g -x RACK_ATTACK_ENABLED 1
set -g -x GPG_TTY (tty)
set -g -x ERL_AFLAGS '-kernel shell_history enabled'

set fish_greeting

function fish_user_key_bindings
  bind \cr reverse_history_search 
end

source ~/.private.fish
source ~/.asdf/asdf.fish

