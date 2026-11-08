# 51-mac-orca

Installs [Orca](https://github.com/stablyai/orca) (`stablyai/orca/orca` cask, from
the author's tap), a desktop app to run coding agents (eg Claude Code) in parallel,
each in its own git worktree. mac only: it's a GUI app.

The official casks have an unrelated `orca` (Plotly), so the cask is always named
with its tap.

Agents use each machine's own login (see Claude Code's package); Orca's settings
are kept by the app, nothing versioned.

## Claude Code integration

On launch, Orca adds its hooks (every hook event) and a `statusLine` to
`~/.claude/settings.json`, calling scripts it writes in `~/.orca/agent-hooks/`.
They're committed as Orca writes them (see
[21-any-claude-code](../21-any-claude-code)): reverting them would come back on the
next launch, and they're no-ops on machines or shells without Orca.
