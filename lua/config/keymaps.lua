local options = { noremap = true, silent = true }
local map = vim.keymap

--tab to indent
map.set('v', '<Tab>', '>', options)
map.set('v', '<S-Tab>', '<', options)

-- jk to normal mode
map.set("i", "jk", "<Esc>", options)

map.set("n", "sv", ":vsplit<CR>")
map.set("n", "sh", ":sview<CR>")

-- Resize
map.set("n", "=", "<cmd>resize +2<CR>")
map.set("n", "-", "<cmd>resize -2<CR>")
map.set("n", "]", "<cmd>vertical resize +5<CR>")
map.set("n", "[", "<cmd>vertical resize -5<CR>")

-- Clipboard
-- Copy
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('n', '<C-c>', '"+yy')

-- Cut
vim.keymap.set('v', '<C-x>', '"+d')

-- Paste
vim.keymap.set({ 'n', 'v' }, '<C-v>', '"+p')
vim.keymap.set('i', '<C-v>', '<C-r>+')

-- ctr + backspace delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<BS>', '<C-W>', { noremap = true, silent = true })

--ctrl + A select all
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG<CR>', options);
vim.api.nvim_set_keymap('i', '<A-z>', '<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-x>', '>', { noremap = true, silent = true })

-- navigate buffers
map.set('n', '<C-h>', '<C-w><Left>', options)
map.set('n', '<C-l>', '<C-w><Right>', options)
map.set('n', '<C-k>', '<C-w><Up>', options)
map.set('n', '<C-j>', '<C-w><Down>', options)

-- Better indenting (stay in visual mode)
map.set("v", "<", "<gv")
map.set("v", ">", ">gv")


-- Save with ctrl + s
map.set({ "n", "v", "i" }, "<C-S>", "<C-c>:wa<cr>", { silent = true, desc = "Save" })
map.set({ "n", "v", "i" }, "<leader>ww", "<C-c>:wa<cr>", { silent = true, desc = "Save" })
map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- LSP
map.set("n", "<F2>", vim.lsp.buf.rename, options)

map.set('n', 'gd', vim.lsp.buf.definition, {})
map.set('n', 'gi', vim.lsp.buf.implementation, {})
map.set('n', 'gt', vim.lsp.buf.document_symbol, options)

map.set("n", "<Leader>f", vim.lsp.buf.format, options)
map.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action({
    filter = function(action)
      -- Include spell check fixes in code actions
      return action.kind ~= nil
    end,
    apply = true,
  })
end, { desc = "Code Action" })
map.set('v', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action (Visual)" })
map.set('n', '<gh', vim.lsp.buf.signature_help, options)
map.set('n', '<A-l>', ':BufferLineCycleNext<CR>', options)
map.set('n', '<A-h>', ':BufferLineCyclePrev<CR>', options)
map.set('n', '<C-w>', ':bdelete<CR>', options)
map.set('n', '<A-w>', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', options)
map.set('n', 'E', vim.diagnostic.open_float, options)
map.set('n', 'ne', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>', options)
map.set('n', 'nw', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING})<CR>', options)

-- Spell check (using util_spell module)
local util_spell = require("utils.util_spell")

map.set('n', '<leader>ss', util_spell.toggle_spell, { desc = "Toggle Spell Check" })
map.set('n', '<leader>sf', 'z=', { desc = "Spell Fix Suggestions", noremap = true })
map.set('n', ']s', ']s', { desc = "Next Spelling Error" })
map.set('n', '[s', '[s', { desc = "Previous Spelling Error" })
map.set('n', '<leader>sg', util_spell.add_word_to_spellfile, { desc = "Add word to spell file (ignore)" })
map.set('n', '<leader>sga', util_spell.add_all_to_spellfile, { desc = "Add all spelling errors to spell file" })


-- Move Lines
map.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- go to definition split
map.set('n', 'gs', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd l')
  vim.lsp.buf.definition()
end, options)

--suspend
vim.keymap.set('n', '<Leader>z', '<C-z>', { noremap = true, silent = true })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { silent = true })


