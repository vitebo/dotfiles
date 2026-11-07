---
paths:
  - "**/*.sh"
---

# Shell scripts

- Bash scripts start with `#!/usr/bin/env bash` and `set -euo pipefail`.
- Scripts must run on both macOS (bash 3.2, BSD tools) and Linux (GNU tools):
  avoid GNU-only flags (eg `sed -i` without a suffix, `readlink -f`) and bash 4+
  features (eg associative arrays, `${var,,}`).
- Quote every expansion (`"${var}"`), and use `local` for function variables.
