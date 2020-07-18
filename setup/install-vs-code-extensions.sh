#!/usr/local/bin/zsh

for extension in $(cat vscode.extensions); do
  code --install-extension $extension
done

