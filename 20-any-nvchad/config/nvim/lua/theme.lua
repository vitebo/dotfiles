-- dotfiles: Catppuccin following the terminal's light / dark mode (CLAUDE.md
-- "Themes"): Latte when 'background' is light, Mocha (NvChad's "catppuccin")
-- when dark. Nvim sets 'background' from the terminal's color at startup (OSC 11,
-- before this config runs); setup() also asks the terminal to report each change
-- (mode 2031), so the theme follows Ghostty (and macOS) live, through tmux too.
-- Each theme gets its own base46 cache dir, compiled the first time it's used.

local M = {}

-- NvChad theme matching 'background'.
function M.name()
  return vim.o.background == "light" and "catppuccin-latte" or "catppuccin"
end

-- base46 cache dir of a theme.
function M.cache(name)
  return vim.fn.stdpath "data" .. "/base46/" .. name .. "/"
end

-- Switches NvChad to the theme matching 'background', when it isn't already (or
-- always, with `force`). base46 reads the cache dir when it's loaded, so it's
-- reloaded first: otherwise it would compile the new theme into the previous
-- theme's dir.
local function apply(force)
  local name = M.name()
  local base46 = require("nvconfig").base46
  if base46.theme == name and not force then
    return
  end
  base46.theme = name
  vim.g.base46_cache = M.cache(name)
  require("plenary.reload").reload_module "base46"
  require("base46").load_all_highlights()
end

-- True when the Normal background isn't the current theme's: setting 'background'
-- resets the highlights to Nvim's defaults. (With base46 `transparency` or a Normal
-- hl_override this would always be true: every start would recompile.)
local function highlights_reset()
  local expected = require("base46").get_theme_tb("base_16").base00
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  return normal ~= tonumber(expected:sub(2), 16)
end

function M.setup()
  -- OptionSet doesn't fire during startup: a report (or Nvim's late OSC 11 answer)
  -- arriving before VimEnter changes 'background' without switching the theme.
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    desc = "dotfiles: catch 'background' changes made during startup",
    callback = function()
      if require("nvconfig").base46.theme ~= M.name() or highlights_reset() then
        apply(true)
      end
    end,
  })

  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    desc = "dotfiles: switch the Catppuccin flavor with 'background'",
    callback = function()
      vim.schedule(apply)
    end,
  })

  -- Mode 2031 reports and DSR 996 answers: CSI ? 997 ; 1 n (dark) or ; 2 n (light).
  vim.api.nvim_create_autocmd("TermResponse", {
    desc = "dotfiles: follow the terminal's light / dark reports",
    nested = true, -- so setting 'background' triggers the OptionSet above
    callback = function(ev)
      local mode = ev.data.sequence:match "^\27%[%?997;([12])n$"
      if mode then
        vim.o.background = mode == "1" and "dark" or "light"
      end
    end,
  })
  -- Turn on the reports, and ask for the current mode (DSR 996) in case the
  -- startup background guess was off (eg tmux answering for an old color).
  vim.api.nvim_ui_send "\27[?2031h\27[?996n"
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      vim.api.nvim_ui_send "\27[?2031l"
    end,
  })
end

return M
