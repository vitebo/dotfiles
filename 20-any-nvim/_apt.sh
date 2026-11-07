#!/usr/bin/env bash
# apt ships a Neovim older than NvChad requires (0.11+), so Neovim and
# tree-sitter come from their GitHub releases.

_dot_apt_install git curl ca-certificates tar gzip unzip build-essential ripgrep

case "$(uname -m)" in
    x86_64)        nvim_arch="x86_64"; tree_sitter_arch="x64" ;;
    aarch64|arm64) nvim_arch="arm64";  tree_sitter_arch="arm64" ;;
    *)
        _dot_err "Unsupported architecture: $(uname -m)"
        return 1
        ;;
esac

nvim_version="$(nvim --version 2>/dev/null | head -n 1 | sed -e 's/^NVIM v//' -e 's/-.*//')"
if [ "$(printf '%s\n' 0.11.0 "${nvim_version:-0}" | sort -V | head -n 1)" != "0.11.0" ]; then
    download_dir="$(mktemp -d)"
    curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nvim_arch}.tar.gz" \
        | tar -xz -C "${download_dir}"
    _dot_sudo rm -rf /opt/nvim
    _dot_sudo mv "${download_dir}/nvim-linux-${nvim_arch}" /opt/nvim
    _dot_sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm -rf "${download_dir}"
fi

if ! command -v tree-sitter >/dev/null 2>&1; then
    download_dir="$(mktemp -d)"
    curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${tree_sitter_arch}.gz" \
        | gunzip > "${download_dir}/tree-sitter"
    _dot_sudo install -m 755 "${download_dir}/tree-sitter" /usr/local/bin/tree-sitter
    rm -rf "${download_dir}"
fi
