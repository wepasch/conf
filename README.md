# Mac
1. Get setup.sh:
```zsh
curl -L -o ~/setup.sh "https://raw.githubusercontent.com/wepasch/configs/main/setup.sh?$(date +%s)"
```
2. Executing setup.sh will
- clone the dotfiles repo into $HOME/dotfies
- clone tpm repo
- create symlinks for $HOME/.zshrc and other files in $HOME/.config
```zsh
zsh ~/setip.sh
```
3. Install with brewfile:
```zsh
brew bundle --file=~/.config/homebrew/brewfile
```
5. Open tmux and press ctrl-a + I to install plugins.




