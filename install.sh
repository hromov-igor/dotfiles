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
