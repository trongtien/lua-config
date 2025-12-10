vim.g.mapleader = " "

require("config.lazy")
require("config.keymaps")
require("config.options")

function ColorMyPencils()
  vim.cmd("colorscheme rose-pine")
  -- Uncomment these lines if you want transparent background
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

vim.lsp.enable({
  "astro",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "ts_ls",
  "emmet_language_server",
  "emmet_ls",
  "lua_ls",
  "clangd",
  "jsonls",
  "powershell_es",
  "lemminx",
})
