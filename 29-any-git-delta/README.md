# 29-any-git-delta

Installs [delta](https://github.com/dandavison/delta) (`git-delta` package, `delta`
command): a syntax-highlighting pager for `git diff`, `git show`, `git log -p`,
`git add -p`, blame and grep output.

- `~/.config/git-delta/git-delta.config` -> `config/git-delta.config`: delta's
  recommended git config (pager, `n` / `N` to jump between files, `zdiff3`
  conflicts). Light / dark mode detected from the terminal (lazygit passes it
  with `--light` / `--dark`) and syntax colors from the terminal's 16 ANSI colors
  (`syntax-theme = ansi`): syntax colors follow Ghostty's Catppuccin flavor; the
  added / removed line backgrounds are delta's own light / dark defaults.
- The git config ([12-any-git](../12-any-git)) includes that file; git ignores
  the include when it's missing, so git only uses delta where it's installed.

Side by side, for one command: `git -c delta.side-by-side=true diff`, or toggle
it for the shell session with `export DELTA_FEATURES=+side-by-side` (`+` to undo).

Prerequisites:

- [12-any-git](../12-any-git)
