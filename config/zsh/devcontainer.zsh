# ~/.config/zsh/devcontainer.zsh — Dev Container helpers.
#
# The container is located by its devcontainer.local_folder label (set
# automatically by `devcontainer up`), never by its Docker-generated name.
# We never rename containers and never set container_name. One project per
# directory: the current directory uniquely identifies the container.
#
# The `dev` prefix avoids clashing with the `dc*` aliases shipped by Oh My
# Zsh's docker / docker-compose plugins.
#
# `devup` mounts a shared named volume at DEVCONTAINER_CACHE_DIR and uses it as
# a persistent cache across container recreations. It holds:
#   - the dotfiles clone (via --dotfiles-target-path), so `devcontainer up`
#     skips re-cloning on later runs (its installer does
#     `[ -e <path> ] || git clone ...`);
#   - Neovim's data (XDG_DATA_HOME, exported by .zshrc when the dir exists), so
#     lazy.nvim plugins and Mason tools persist.
# _dev_prepare_cache makes the volume writable before `up` so the non-root
# container user can populate it during the dotfiles install.

# One shared volume per machine, reused by every project (see PLAN.md: one
# container per directory). Override to isolate or rename.
: "${DEVCONTAINER_CACHE_VOLUME:=dotfiles-cache}"
# Mounted outside $HOME on purpose: mounting inside ~/.local would make Docker
# create ~/.local root-owned, breaking install.sh's `mkdir ~/.local/bin`.
: "${DEVCONTAINER_CACHE_DIR:=/dotfiles-cache}"
# Clone target for the dotfiles repo, inside the volume so it survives
# recreation and turns later `devup` runs into a cache hit.
: "${DEVCONTAINER_DOTFILES_DIR:=${DEVCONTAINER_CACHE_DIR}/dotfiles}"

# --- Private helpers -----------------------------------------------------

# Absolute path used by the devcontainer.local_folder label. Accepts an
# optional folder (defaults to the current directory).
_dev_local_folder() {
    local folder="${1:-.}"
    (cd "$folder" 2>/dev/null && pwd) || return 1
}

# Container ID for a given folder (defaults to the current directory).
# Prints nothing and returns 0 even when no container exists.
_dev_container_id() {
    local folder
    folder=$(_dev_local_folder "${1:-.}") || return 1
    docker ps --all \
        --filter "label=devcontainer.local_folder=${folder}" \
        --format '{{.ID}}' | head -1
}

# Resolve the container ID or fail with a friendly message. Prints the ID to
# stdout on success; prints guidance to stderr and returns 1 otherwise.
_dev_require_container() {
    local id
    id=$(_dev_container_id "${1:-.}") || return 1
    if [ -z "$id" ]; then
        printf 'No Dev Container found for %s\n' "$(_dev_local_folder "${1:-.}")" >&2
        printf 'Run `devup` to create one.\n' >&2
        return 1
    fi
    printf '%s\n' "$id"
}

# Ensure the cache volume exists and its root is writable before `up`, so the
# non-root container user can clone the dotfiles into it and write Neovim's
# cache. A fresh named volume is root-owned; files created inside inherit
# whoever creates them, so a world-writable root is enough and avoids guessing
# the container's UID. Best effort — warn but let `devup` proceed.
_dev_prepare_cache() {
    docker volume inspect "$DEVCONTAINER_CACHE_VOLUME" >/dev/null 2>&1 \
        || docker volume create "$DEVCONTAINER_CACHE_VOLUME" >/dev/null 2>&1
    # Mount at the same path the real container uses, so overridden paths match.
    docker run --rm -v "${DEVCONTAINER_CACHE_VOLUME}:${DEVCONTAINER_CACHE_DIR}" busybox \
        chmod 0777 "$DEVCONTAINER_CACHE_DIR" >/dev/null 2>&1 \
        || printf 'devup: could not prepare cache volume %s (continuing)\n' \
            "$DEVCONTAINER_CACHE_VOLUME" >&2
}

# Drop the cached dotfiles clone so the next `up` re-clones the repo. Keeps the
# Neovim cache (a sibling under the volume) warm. Used by `devup --fresh`.
_dev_clear_dotfiles_cache() {
    docker run --rm -v "${DEVCONTAINER_CACHE_VOLUME}:${DEVCONTAINER_CACHE_DIR}" busybox \
        rm -rf "$DEVCONTAINER_DOTFILES_DIR" >/dev/null 2>&1
}

# --- Public functions ----------------------------------------------------

# Print the container ID for the current directory (empty if none exists).
devid() {
    _dev_container_id "${1:-.}"
}

# Bring up the Dev Container installing these dotfiles, with a persistent
# cache volume for the dotfiles clone and Neovim's plugins/tooling.
# Usage: devup [workspace-folder]  (defaults to the current directory).
devup() {
    local folder="${1:-.}"
    _dev_prepare_cache
    devcontainer up \
        --remove-existing-container \
        --dotfiles-repository https://github.com/vitebo/dotfiles/ \
        --dotfiles-install-command install.sh \
        --dotfiles-target-path "$DEVCONTAINER_DOTFILES_DIR" \
        --mount "type=volume,source=${DEVCONTAINER_CACHE_VOLUME},target=${DEVCONTAINER_CACHE_DIR}" \
        --workspace-folder "$folder"
}

# Open an interactive shell inside the container.
devexec() {
    local id
    id=$(_dev_require_container) || return 1
    docker exec -it "$id" zsh
}

# Follow the container logs.
devlogs() {
    local id
    id=$(_dev_require_container) || return 1
    docker logs -f "$id"
}

# Stop the container.
devstop() {
    local id
    id=$(_dev_require_container) || return 1
    docker stop "$id"
}

# Remove the container (force).
devrm() {
    local id
    id=$(_dev_require_container) || return 1
    docker rm -f "$id"
}

# Show useful information about the Dev Container.
devstatus() {
    local id
    id=$(_dev_require_container) || return 1
    docker inspect "$id" --format '\
Container ID: {{.Id}}
Name:         {{.Name}}
Status:       {{.State.Status}}
Image:        {{.Config.Image}}
Local folder: {{index .Config.Labels "devcontainer.local_folder"}}
Config file:  {{index .Config.Labels "devcontainer.config_file"}}'
}
