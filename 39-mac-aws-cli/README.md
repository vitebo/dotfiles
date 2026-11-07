# 39-mac-aws-cli

Installs the [AWS CLI](https://aws.amazon.com/cli/) v2 (`awscli` formula).

- mac only: projects needing AWS in a devcontainer install it from their own
  `devcontainer.json`, with the credentials that make sense there.
- Not versioned: `~/.aws/config` and `~/.aws/credentials` (profiles, SSO, keys),
  per machine like gh's `hosts.yml`. Set them up with `aws configure` or
  `aws configure sso`. Kept in `~/.aws` (not `~/.config/aws-cli`), since
  some tools only look there.
- oh-my-zsh's `aws` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)), when the CLI
  is installed: completion, `asp <profile>` / `asr <region>` to switch profile /
  region, `acp` to switch credentials, and the active profile on the right of the
  prompt (only when one is set).
