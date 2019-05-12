function reverse_history_search
  history | fzf --no-sort --height 40% | read -l command
  if test $command
    commandline -rb $command
  end
end
bind \cr reverse_history_search 
