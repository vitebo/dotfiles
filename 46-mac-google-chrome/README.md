# 46-mac-google-chrome

Installs [Google Chrome](https://www.google.com/chrome/) (`google-chrome` cask,
auto-updates), the web browser. mac only: it's a GUI app.

## Default browser

macOS asks for confirmation before changing the default browser, so it's set by
hand, once per machine (installers don't change system preferences):

System Settings → Desktop & Dock → Default web browser → Google Chrome
(or Chrome's own "make default" prompt on first launch).

Accounts, profiles and settings are synced by Chrome itself (Google account),
nothing versioned.

## Claude in Chrome (by hand, once per machine)

The [Claude in Chrome](https://code.claude.com/docs/en/chrome.md) extension lets
Claude Code drive this Chrome, with your logins, for flows the
[chrome-devtools MCP](../53-mac-chrome-devtools-mcp)'s separate Chrome can't do (eg
Cloudflare Turnstile). Extensions aren't installed by scripts, and it needs your
account, so:

1. Install [the extension](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn)
   from the Chrome Web Store and pin it.
2. Sign in to it with the same claude.ai account and organization as Claude Code
   (`/status` shows the organization).
3. Run `claude --chrome` once: Claude Code registers its native messaging host
   (`~/Library/Application Support/Google/Chrome/NativeMessagingHosts/`); restart
   Chrome if the extension isn't detected. `/chrome` shows the status.

Keep `/chrome` → "Enabled by default" off: sessions get it with `claude --chrome`
only when needed ([21-any-claude-code](../21-any-claude-code)'s `rules/browser.md`
says when). Needs a direct Anthropic plan and a `/login` sign-in, not an API key.
