-- dotfiles: one base46 cache per theme, Latte or Mocha from 'background' (lua/theme.lua).
local theme = require "theme"
vim.g.base46_cache = theme.cache(theme.name())
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme (dotfiles: compiled the first time each theme is used)
if vim.uv.fs_stat(vim.g.base46_cache .. "defaults") then
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
else
  require("base46").load_all_highlights()
end

require "options"
require "autocmds"
theme.setup() -- dotfiles: follow the terminal's light / dark changes

vim.schedule(function()
  require "mappings"
end)
