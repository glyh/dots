-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require 'lspconfig'

-- if you just want default config for the servers then put them in a table
local servers = {
  'clangd', 'clojure_lsp', 'zls', 'gopls', 'ocamllsp',
  'rust_analyzer', 'kotlin_language_server', 'pyright',
  'nim_langserver', 'eslint', 'tsserver'}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
  }
end
