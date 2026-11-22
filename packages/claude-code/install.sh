#!/usr/bin/env bash
# Claude Code: agentic coding CLI.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "claude-code"
_dot_require curl

# Native installer, same on mac and linux; it auto-updates afterwards.
if [ ! -x "${HOME}/.local/bin/claude" ]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

_dot_link_zsh "${DOT_PACKAGE_DIR}/config/21-claude-code.zsh"

# Shared config only, linked file by file: ~/.claude also holds per-machine
# state and files that stay out of the repo (eg work-only rules).
_dot_link "${DOT_PACKAGE_DIR}/config/settings.json" "${HOME}/.claude/settings.json"
_dot_link "${DOT_PACKAGE_DIR}/config/statusline.sh" "${HOME}/.claude/statusline.sh"
if [ -f "${DOT_PACKAGE_DIR}/config/CLAUDE.md" ]; then
    _dot_link "${DOT_PACKAGE_DIR}/config/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
fi
for rule_file in "${DOT_PACKAGE_DIR}"/config/rules/*.md; do
    if [ -f "${rule_file}" ]; then
        _dot_link "${rule_file}" "${HOME}/.claude/rules/$(basename "${rule_file}")"
    fi
done

# Git filter keeping settings.json's per-machine keys out of the repo (.gitattributes).
if command -v git >/dev/null && git -C "${DOT_ROOT}" rev-parse --git-dir >/dev/null 2>&1; then
    git -C "${DOT_ROOT}" config filter.dot-claude-settings.clean \
        "bash packages/claude-code/git-clean-settings.sh"
fi

_dot_ok "claude-code installed"
