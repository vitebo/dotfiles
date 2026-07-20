require "nvchad.options"

local o = vim.o

o.relativenumber = true

-- Usa o clipboard do sistema para y/p
o.clipboard = "unnamedplus"

-- Copia via OSC 52: funciona dentro de container/SSH, o terminal do host
-- recebe a sequencia de escape e escreve no clipboard do macOS.
local osc52 = require "vim.ui.clipboard.osc52"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy "+",
    ["*"] = osc52.copy "*",
  },
  paste = {
    ["+"] = osc52.paste "+",
    ["*"] = osc52.paste "*",
  },
}

