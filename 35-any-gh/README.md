# 35-any-gh

Installs [gh](https://cli.github.com), GitHub's command line tool (mac: brew;
linux: GitHub's official apt repository, since distros ship old versions).

- `~/.config/gh/config.yml` -> `config/config.yml`: gh's default config, as gh
  writes it (`git_protocol: https`, `co` alias for `pr checkout`). gh rewrites this
  file itself (`gh config set`, `gh alias set`), dropping any comment of ours:
  review those diffs, commit if shared.
- Login: `gh auth login` on each machine, with that machine's account. It's stored
  in `~/.config/gh/hosts.yml` and the keychain, not versioned (hence config files
  are linked one by one).

## Integrations

- [12-any-git](../12-any-git): git uses gh's login for https on github.com
  (`~/.config/gh/git-credential.config`, included by the git config; what
  `gh auth setup-git` would write). No token prompt on `git push`.
- [29-any-git-delta](../29-any-git-delta): `GH_PAGER=delta` (`config/gh.zsh`), so
  `gh pr diff` looks like `git diff`.

Prerequisites:

- [11-any-curl](../11-any-curl) (linux)
- [12-any-git](../12-any-git)
