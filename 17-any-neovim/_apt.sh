#!/usr/bin/env bash
# apt ships an outdated Neovim: installed from the GitHub release instead,
# unless a recent enough one (0.12+, for 20-any-nvchad's theme) is already there.

nvim_version="$(nvim --version 2>/dev/null | head -n 1 | sed -e 's/^NVIM v//' -e 's/-.*//')"
if [ "$(printf '%s\n' 0.12.0 "${nvim_version:-0}" | sort -V | head -n 1)" = "0.12.0" ]; then
    return 0
fi

case "$(uname -m)" in
    x86_64)        arch="x86_64" ;;
    aarch64|arm64) arch="arm64" ;;
    *)
        _dot_err "Unsupported architecture: $(uname -m)"
        return 1
        ;;
esac

_dot_require curl tar

download_dir="$(mktemp -d)"
curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
    | tar -xz -C "${download_dir}"
_dot_sudo rm -rf /opt/nvim
_dot_sudo mv "${download_dir}/nvim-linux-${arch}" /opt/nvim
_dot_sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
rm -rf "${download_dir}"
