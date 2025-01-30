#! /bin/zsh

CONFS=("ghostty/config" "karabiner/karabiner.json" "tmux/tmux.conf" "/zshrc")
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
  local line="$1"
  local file="$2"
  if ! grep -qF "$line" "$file"; then
    echo "Adding the following line into $file: $line"
    echo -e "\n$line" >> "$file"
  else
    echo "Line already exists in $file."
  fi
}

create_symlink () {
  local src_path=$1/$2
  local dst_dir=$3
  local dst_path=$4
  if [ ! -f "$src_path" ]; then
    echo ERROR: no file at $src_path
    return 1
  fi
  if [ ! -d "$dst_dir" ]; then
    mkdir -p $dst_dir
  fi
  if [ ! -f "$dst_path" ]; then
    ln -s $src_path $dst_path
  fi
}

create_symlinks () {
for conf in "${CONFS[@]}"; do
  local dir="${conf%%/*}"
  local path="${conf#*/}"
  create_symlink $DIR_CONFS/$dir $path $DIR_CONF/$dir $path 
done
  
}

#install_homebrew
create_symlinks














