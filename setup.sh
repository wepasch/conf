#! /bin/zsh

CONFS=("ghostty/config" "karabiner/karabiner.json" "tmux/tmux.conf")
URL_REPO="git@github.com:wepasch/configs.git"
URL_TPM="https://github.com/tmux-plugins/tpm"
DIR_CONFS=$HOME/configs
DIR_CONF=$HOME/.config
PATH_ZSHRC=$HOME/.zshrc
DIR_TPM="$DIR_CONF/tmux/plugins/tpm"

install_homebrew () {
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  add_if_absent_into 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$PATH_ZSHRC"
  if [ -f "$PATH_ZSHRC" ]; then
    source "$PATH_ZSHRC"
  else
    echo "ERROR: $PATH_ZSHRC not found, unable to source it."
  fi
}

add_if_absent_into () {
  local line="$1"
  local file="$2"
  if ! grep -qF "$line" "$file"; then
    echo -e "\n$line" >> "$file"
  fi
}

create_symlink () {
  src_path="$DIR_CONFS/$1/$2"
  dst_dir="$DIR_CONF/$1"
  dst_path="$dst_dir/$2"
  if [ ! -f "$src_path" ]; then
    echo "ERROR: No file at $src_path"
    return 1
  fi
  mkdir -p "$dst_dir"
  if [ ! -f "$dst_path" ]; then
    ln -s "$src_path" "$dst_path"
  fi
}

create_symlinks () {
  for conf in "${CONFS[@]}"; do
    _dir="${conf%%/*}"
    _path="${conf#*/}"
    create_symlink "$_dir" "$_path"   
  done
  src_zshrc="$DIR_CONFS/.zshrc"
  if [ -f "$src_zshrc" ]; then
    if [ ! -f "$PATH_ZSHRC" ]; then
      ln -s "$src_zshrc" "$PATH_ZSHRC"
      source $PATH_ZSHRC
    fi
  else
    echo ERROR: Found no zshrc at $src_zshrc.
    return 1
  fi
}

get_configs () {
    if [ -d "$DIR_CONFS/.git" ]; then
    git -C "$DIR_CONFS" pull origin main
  else
    git clone "$REPO_URL" "$DIR_CONFS"
  fi
}

install_to () {
  url_repo=$1
  dir_dst=$2
  if [ -d "$dir_dst/.git" ]; then
    git -C "$dir_dst" pull "$url_repo"
  else
    mkdir -p $dir_dst
    git clone "$url_repo" "$dir_dst"
  fi 
}

install_to $URL_REPO $DIR_CONFS
install_to $URL_TPM $DIR_TPM 
create_symlinks
#install_homebrew
