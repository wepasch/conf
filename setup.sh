#! /bin/zsh

CONFS=("ghostty/config" "karabiner/karabiner.json" "tmux/tmux.conf" "/zshrc")
REPO_URL="git@github.com:wepasch/configs.git"
DIR_CONFS=$HOME/configs
DIR_CONF=$HOME/.config
PATH_ZSHRC=$HOME/.zshrc

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
    echo "Adding the following line into $file: $line"
    echo -e "\n$line" >> "$file"
  else
    echo "Line already exists in $file."
  fi
}

create_symlink () {
  local src_path="$1/$2"
  local dst_dir="$3"
  local dst_path="$4"
  if [ ! -f "$src_path" ]; then
    echo "ERROR: No file at $src_path"
    return 1
  fi
  if [ ! -d "$dst_dir" ]; then
    mkdir -p "$dst_dir"
  fi
  if [ ! -f "$dst_path" ]; then
    ln -s "$src_path" "$dst_path"
    echo "Created symlink: $dst_path -> $src_path"
  else
    echo "Symlink already exists: $dst_path"
  fi
}

create_symlinks () {
  for conf in "${CONFS[@]}"; do
    local dir="${conf%%/*}"
    local path="${conf#*/}"
    create_symlink "$DIR_CONFS/$dir" "$path" "$DIR_CONF/$dir" "$path"
  done
}

get_configs () {
    if [ -d "$DIR_CONFS/.git" ]; then
    git -C "$DIR_CONFS" pull origin main
  else
    git clone "$REPO_URL" "$DIR_CONFS"
  fi
}

# install_homebrew
get_configs
create_symlinks
