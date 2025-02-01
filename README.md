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
zsh ~/setup.sh
```
> warnings about missing homebrew directory etc. can be ignored 
3. Install homebrew:
```zsh
~/setup.sh -h
```
4. Open a new terminal.
5. Install with brewfile:
```zsh
~/setup.sh -i
```
or via
```zsh
brew bundle --file=~/.config/homebrew/brewfile
```
6. Open tmux and press ctrl-a + I to install plugins.
7. Setup nvim with:
```zsh
/setup.sh -n
```





