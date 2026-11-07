#!/usr/bin/env bash
# Not packaged by apt: installed from the GitHub release binary.

if command -v tree-sitter >/dev/null 2>&1; then
    return 0
fi

case "$(uname -m)" in
    x86_64)        arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    *)
        _dot_err "Unsupported architecture: $(uname -m)"
        return 1
        ;;
esac

download_dir="$(mktemp -d)"
curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${arch}.gz" \
    | gunzip > "${download_dir}/tree-sitter"
_dot_sudo install -m 755 "${download_dir}/tree-sitter" /usr/local/bin/tree-sitter
rm -rf "${download_dir}"
