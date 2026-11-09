# 54-any-chafa

Installs [chafa](https://hpjansson.org/chafa/), which shows images (and animated
GIFs) in the terminal: `chafa image.png`.

It picks the best format the terminal supports: Ghostty's kitty graphics protocol
for full-resolution images, Unicode blocks with colors elsewhere. In a devcontainer
the image renders in the host's Ghostty too.

## Integrations

- [34-any-tmux](../34-any-tmux): `allow-passthrough on` lets chafa reach Ghostty
  through tmux, so images keep full resolution inside tmux.
