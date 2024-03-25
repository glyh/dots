dofile(vim.g.base46_cache .. "syntax")

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

for _, config in pairs(parser_configs) do
  config.install_info.url = config.install_info.url:gsub("github.com", _G.GITHUB)
end

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "c",
    "go",
    "lua",
    "cuda",
    -- "clojure",
    -- "dart",
  },
}
