# 36-any-jq

Installs [jq](https://jqlang.org), a command-line JSON processor, on linux.
macOS ships it (`/usr/bin/jq`, since macOS 15), so there's no `_brew.sh`.

Examples: `curl -s … | jq .`, `jq '.items[].name' file.json`, `jq -r '.version' package.json`.
