# 56-mac-cloudflared

Installs [cloudflared](https://developers.cloudflare.com/tunnel/), the Cloudflare
Tunnel client, to expose a local server on a public URL:

```sh
cloudflared tunnel --url http://localhost:3100   # prints a https://….trycloudflare.com URL
```

- Quick tunnels (`--url`) need no Cloudflare account. Named tunnels need
  `cloudflared tunnel login`, whose certificate stays in `~/.cloudflared/`, per
  machine, not versioned.
- mac only: devcontainer ports are forwarded to the mac, so the tunnel runs on the
  host for them too.
