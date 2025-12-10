local opt = vim.opt;

opt.expandtab = true
opt.shiftwidth = 2

opt.pumheight = 10
vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
vim.o.winborder = 'rounded'

-- Spell checking
opt.spell = false  -- Disable by default, toggle with <leader>ss
opt.spelllang = { "en_us" }
opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

-- Disable spell check for specific filetypes (programming languages)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "python", "c", "cpp", "rust", "go", "java", "svelte", "vue", "jsx", "tsx" },
  callback = function()
    vim.wo.spell = false
  end,
})

-- Enable spell check only for documentation/text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.wo.spell = true
  end,
})

-- Fix delay issues
opt.timeout = true
opt.timeoutlen = 300  -- Time to wait for a mapped sequence (default 1000ms)
opt.updatetime = 200  -- Faster completion and diagnostics (default 4000ms)

opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99

-- Enable diagnostics
vim.diagnostic.config({
  virtual_text = true,     -- Show inline diagnostics
  signs = true,            -- Show signs in the gutter
  underline = true,        -- Underline errors
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true,    -- Sort diagnostics by severity
})

-- Setup spell checking utilities
local util_spell = require("utils.util_spell")
util_spell.setup_autocmds()


vim.api.nvim_create_user_command("RestartAll", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
  print("✅ It's me, Good. I'm here behind you.")
end, {})

vim.opt.shortmess:append { I = true, c = false, F = false }
-- I → skip the intro message
-- c → suppress completion messages
-- F → suppress file info messages

-- remove "Press enter to continue message"
vim.opt.more = false
