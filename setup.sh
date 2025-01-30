#! /bin/zsh

CONFS==("ghostty/config" "karabiner/karabiner.json" "tmux/tmux.conf" "/zshrc")
DIR_CONFS=$HOME/configs
DIR_CONF=$HOME/.config
PATH_ZSHRC=$HOME/.zshrc

install_homebrew () {
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi
  add_if_absent_into 'eval "$(/opt/homebrew/bin/brew shellenv)"'  $PATH_ZSHRC
  source $PATH_ZSHRC
}

add_if_absent_into () {
  local line = "$1"
  local file = "$2"
  if ! grep -qF "$line" "$file"; then
    echo "Adding the following line into $file: $line"
    echo -e "\n$line" >> "$file"
  else
    echo "Line already exists in $file."
  fi
}

create_symlink () {
  local src_path = $DIR_CONFS/$1/$2
  if [ -n $3 ]; then
    local src_dir = $DIR_CONF/$3
    local dst_path = $dst_dir/$4
  else
    local src_dir = $DIR_CONF/$1
    local dst_path = $dst_dir/$2
  fi  
}

create_symlinks () {
for conf in "${CONFS[@]}"; do
    echo "${conf%%/*}"
    echo "${conf#*/}"
done
  
}

#install_homebrew
create_symklinks














