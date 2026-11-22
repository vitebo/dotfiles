#!/usr/bin/env bash
# Loads every internal `_dot_*` function.

DOT_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for _dot_function in "${DOT_LIB_DIR}"/functions/*.sh; do
    source "${_dot_function}"
done
unset _dot_function
