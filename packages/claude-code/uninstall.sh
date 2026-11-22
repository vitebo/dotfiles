#!/usr/bin/env bash
# Claude Code: agentic coding CLI.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "claude-code (uninstall)"

if command -v git >/dev/null && git -C "${DOT_ROOT}" rev-parse --git-dir >/dev/null 2>&1 \
    && git -C "${DOT_ROOT}" config --get filter.dot-claude-settings.clean >/dev/null; then
    git -C "${DOT_ROOT}" config --unset filter.dot-claude-settings.clean
fi

for rule_file in "${DOT_PACKAGE_DIR}"/config/rules/*.md; do
    if [ -f "${rule_file}" ]; then
        _dot_unlink "${rule_file}" "${HOME}/.claude/rules/$(basename "${rule_file}")"
    fi
done
_dot_unlink "${DOT_PACKAGE_DIR}/config/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
_dot_unlink "${DOT_PACKAGE_DIR}/config/statusline.sh" "${HOME}/.claude/statusline.sh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/settings.json" "${HOME}/.claude/settings.json"
_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/21-claude-code.zsh"

# Native install: the launcher and its versions. ~/.claude (sessions, history) and
# ~/.claude.json (account) are user state and stay.
rm -f "${HOME}/.local/bin/claude"
rm -rf "${HOME}/.local/share/claude"

_dot_ok "claude-code uninstalled"
