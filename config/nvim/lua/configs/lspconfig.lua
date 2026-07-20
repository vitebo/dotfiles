require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "cssls",
  "eslint",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "ruby_lsp",
  "tailwindcss",
  "ts_ls",
  "yamlls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
