#!/usr/bin/env bash
# tmux: terminal multiplexer.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "tmux (uninstall)"

# The plugin clones; tmux-resurrect's saved sessions are user state and stay.
plugins_dir="${HOME}/.local/share/tmux/plugins"
for plugin in $(sed -n 's/^set-option -g @plugin "\(.*\)"$/\1/p' "${DOT_PACKAGE_DIR}/config/tmux.conf"); do
    rm -rf "${plugins_dir:?}/${plugin#*/}"
done
for dir in "${plugins_dir}" "$(dirname "${plugins_dir}")"; do
    if [ -d "${dir}" ] && [ -z "$(ls -A "${dir}")" ]; then
        rmdir "${dir}"
    fi
done

_dot_unlink "${DOT_PACKAGE_DIR}/config/claude-hook.sh" "${HOME}/.claude/hooks/tmux-agent-state.sh"
_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/34-tmux.zsh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/pane-labels.sh" "${HOME}/.config/tmux/pane-labels.sh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/claude-agents.sh" "${HOME}/.config/tmux/claude-agents.sh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/status-line.conf" "${HOME}/.config/tmux/status-line.conf"
_dot_unlink "${DOT_PACKAGE_DIR}/config/tmux.conf" "${HOME}/.config/tmux/tmux.conf"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "tmux uninstalled"
