#!/usr/bin/env bash
# Claude Code: agentic coding CLI.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "claude-code"
_dot_require curl

# Native installer, same on mac and linux; it auto-updates afterwards.
if [ ! -x "${HOME}/.local/bin/claude" ]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

_dot_link_zsh "${DOT_PACKAGE_DIR}/config/claude-code.zsh"

# Shared config only, linked file by file: ~/.claude also holds per-machine
# state and files that stay out of the repo (eg work-only rules).
_dot_link "${DOT_PACKAGE_DIR}/config/settings.json" "${HOME}/.claude/settings.json"
if [ -f "${DOT_PACKAGE_DIR}/config/CLAUDE.md" ]; then
    _dot_link "${DOT_PACKAGE_DIR}/config/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
fi
for rule_file in "${DOT_PACKAGE_DIR}"/config/rules/*.md; do
    if [ -f "${rule_file}" ]; then
        _dot_link "${rule_file}" "${HOME}/.claude/rules/$(basename "${rule_file}")"
    fi
done

_dot_ok "claude-code installed"
