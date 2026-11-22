# aws-vpn-client

Installs [AWS Client VPN](https://aws.amazon.com/vpn/client-vpn-download/)
(`aws-vpn-client` cask, auto-updates). mac only: it's a GUI app, and devcontainers
reach the VPN through the host.

- The cask is a `.pkg`, so brew asks for the admin password on the first install.
- Not versioned: VPN profiles (`.ovpn` files from each VPN's admin), imported per
  machine with *File > Manage Profiles*, like the AWS CLI's `~/.aws`.

## Integrations

- [sketchybar](../sketchybar): cloud icon, with a lock when connected,
  crossed out when not, read from the client's logs (`~/.config/AWSVPNClient/logs`); click opens
  the client.
