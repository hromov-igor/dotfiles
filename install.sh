#!/usr/bin/env bash
set -euo pipefail

echo "🛠️ Установка окружения Zsh + плагины + Starship"

# 1. Проверка и установка Zsh
if ! command -v zsh &>/dev/null; then
  echo "➡️ Устанавливаем zsh..."
  if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y zsh git curl
  elif command -v brew &>/dev/null; then
    brew install zsh git curl
  else
    echo "❌ Не удалось установить zsh. Установите вручную."
    exit 1
  fi
else
  echo "✅ Zsh уже установлен"
fi

# 2. oh-my-zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "➡️ Клонируем oh-my-zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
else
  echo "✅ oh-my-zsh уже установлен, обновляем..."
  git -C ~/.oh-my-zsh pull
fi

# 3. Установка плагинов
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_plugin() {
  local name=$1
  local repo=$2
  local plugin_dir="${ZSH_CUSTOM}/plugins/${name}"

  if [ ! -d "$plugin_dir" ]; then
    echo "➡️ Устанавливаем плагин $name"
    git clone "$repo" "$plugin_dir"
  else
    echo "🔄 Плагин $name уже установлен, обновляем..."
    git -C "$plugin_dir" pull
  fi
}

install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
install_plugin zsh-completions https://github.com/zsh-users/zsh-completions.git

# 4. Установка Starship без sudo
if ! command -v starship &>/dev/null; then
  echo "➡️ Устанавливаем Starship prompt (локально без sudo)..."
  mkdir -p ~/.local/bin
  curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin --yes
else
  echo "✅ Starship уже установлен"
fi

# Убедимся, что ~/.local/bin в $PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc
  export PATH="$HOME/.local/bin:$PATH"
  echo "🔧 Добавлен ~/.local/bin в PATH"
fi

# 5. Копирование .zshrc
echo "➡️ Копируем .zshrc в домашнюю директорию"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SOURCE="${REPO_DIR}/.zshrc"
ZSHRC_TARGET="${HOME}/.zshrc"

if [ -f "$ZSHRC_TARGET" ]; then
  echo "🔁 Резервное копирование старого .zshrc → .zshrc.backup"
  cp "$ZSHRC_TARGET" "${ZSHRC_TARGET}.backup"
fi

cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
echo "✅ Новый .zshrc установлен"

# 6. Копирование starship.toml
echo "➡️ Копируем starship.toml в ~/.config"

mkdir -p ~/.config
STARSHIP_CONFIG_SOURCE="${REPO_DIR}/starship.toml"
STARSHIP_CONFIG_TARGET="${HOME}/.config/starship.toml"

if [ -f "$STARSHIP_CONFIG_TARGET" ]; then
  echo "🔁 Резервное копирование старого starship.toml → starship.toml.backup"
  cp "$STARSHIP_CONFIG_TARGET" "${STARSHIP_CONFIG_TARGET}.backup"
fi

cp "$STARSHIP_CONFIG_SOURCE" "$STARSHIP_CONFIG_TARGET"
echo "✅ Конфиг starship.toml установлен"

# 7. Готово
echo "🎉 Установка завершена!"
echo "🔁 Перезапустите терминал или выполните: exec zsh"

# 8. Установка tmux и плагинов
echo "➡️ Проверяем tmux..."

if ! command -v tmux &>/dev/null; then
  echo "➡️ Устанавливаем tmux..."
  if command -v apt &>/dev/null; then
    sudo apt install -y tmux
  elif command -v brew &>/dev/null; then
    brew install tmux
  else
    echo "❌ Не удалось установить tmux. Установите вручную."
    exit 1
  fi
else
  echo "✅ Tmux уже установлен"
fi

# TPM — Tmux Plugin Manager
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  echo "➡️ Устанавливаем TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "✅ TPM уже установлен, обновляем..."
  git -C ~/.tmux/plugins/tpm pull
fi

# Копируем .tmux.conf
echo "➡️ Копируем .tmux.conf в домашнюю директорию"

TMUX_CONF_SOURCE="${REPO_DIR}/.tmux.conf"
TMUX_CONF_TARGET="${HOME}/.tmux.conf"

if [ -f "$TMUX_CONF_TARGET" ]; then
  echo "🔁 Резервная копия старого .tmux.conf → .tmux.conf.backup"
  cp "$TMUX_CONF_TARGET" "${TMUX_CONF_TARGET}.backup"
fi

cp "$TMUX_CONF_SOURCE" "$TMUX_CONF_TARGET"
echo "✅ Новый .tmux.conf установлен"

# Установка плагинов через TPM
echo "➡️ Устанавливаем tmux плагины через TPM..."

# Временно запускаем скрытую tmux-сессию, чтобы выполнить install_plugins.sh
tmux new-session -d -s __plugin_install_session "sleep 1; ~/.tmux/plugins/tpm/scripts/install_plugins.sh"
sleep 2
tmux kill-session -t __plugin_install_session || true

echo "✅ Tmux плагины установлены"
