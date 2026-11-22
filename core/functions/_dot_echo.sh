#!/usr/bin/env bash
# Standardized output messages.

_dot_title() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
_dot_ok()    { printf '\033[32m  ✓ %s\033[0m\n' "$*"; }
_dot_warn()  { printf '\033[33m  ! %s\033[0m\n' "$*" >&2; }
_dot_err()   { printf '\033[31m  ✗ %s\033[0m\n' "$*" >&2; }
