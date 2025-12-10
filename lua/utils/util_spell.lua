local M = {}

-- Spell diagnostics namespace
M.spell_ns = vim.api.nvim_create_namespace("spell_diagnostics")

-- Update spell diagnostics for current buffer
function M.update_spell_diagnostics()
  if not vim.wo.spell then return end

  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    local col = 0
    while col < #line do
      local spell_info = vim.fn.spellbadword(line:sub(col + 1))
      local bad_word = spell_info[1]

      if bad_word == "" then break end

      local start_col = line:find(vim.pesc(bad_word), col + 1, true)
      if start_col then
        table.insert(diagnostics, {
          lnum = lnum - 1,
          col = start_col - 1,
          end_col = start_col - 1 + #bad_word,
          severity = vim.diagnostic.severity.HINT,
          message = "Spelling: " .. bad_word,
          source = "spell",
        })
        col = start_col + #bad_word
      else
        break
      end
    end
  end

  vim.diagnostic.set(M.spell_ns, bufnr, diagnostics, {})
end

-- Toggle spell check
function M.toggle_spell()
  vim.wo.spell = not vim.wo.spell
  if vim.wo.spell then
    vim.notify("Spell check enabled", vim.log.levels.INFO)
    vim.defer_fn(function()
      M.update_spell_diagnostics()
    end, 100)
  else
    vim.notify("Spell check disabled", vim.log.levels.INFO)
    vim.diagnostic.reset(M.spell_ns)
  end
end

-- Add current word to spell file
function M.add_word_to_spellfile()
  local word = vim.fn.expand('<cword>')
  local spell_dir = vim.fn.stdpath('config') .. '/spell'
  local spell_file = spell_dir .. '/en.utf-8.add'

  -- Create spell directory if it doesn't exist
  vim.fn.mkdir(spell_dir, 'p')

  -- Create spell file if it doesn't exist
  if vim.fn.filereadable(spell_file) == 0 then
    vim.fn.writefile({}, spell_file)
  end

  vim.cmd('spellgood! ' .. word)
  vim.cmd('mkspell! ' .. spell_file)
  M.update_spell_diagnostics()
  vim.notify('Added "' .. word .. '" to spell file', vim.log.levels.INFO)
end

-- Add all spelling errors in buffer to spell file
function M.add_all_to_spellfile()
  local bufnr = vim.api.nvim_get_current_buf()
  local namespaces = vim.api.nvim_get_namespaces()
  local spell_ns = namespaces["spell_diagnostics"]

  if not spell_ns then
    vim.notify("No spell diagnostics found", vim.log.levels.WARN)
    return
  end

  local all_diagnostics = vim.diagnostic.get(bufnr, { namespace = spell_ns })
  local added_words = {}

  for _, diag in ipairs(all_diagnostics) do
    local word = diag.message:match("Spelling: (.+)")
    if word and not added_words[word] then
      vim.cmd('spellgood! ' .. word)
      added_words[word] = true
    end
  end

  local count = 0
  for _ in pairs(added_words) do count = count + 1 end

  if count > 0 then
    local spell_dir = vim.fn.stdpath('config') .. '/spell'
    local spell_file = spell_dir .. '/en.utf-8.add'

    -- Create spell directory if it doesn't exist
    vim.fn.mkdir(spell_dir, 'p')

    -- Create spell file if it doesn't exist
    if vim.fn.filereadable(spell_file) == 0 then
      vim.fn.writefile({}, spell_file)
    end

    vim.cmd('mkspell! ' .. spell_file)
    M.update_spell_diagnostics()
    vim.notify('Added ' .. count .. ' words to spell file', vim.log.levels.INFO)
  else
    vim.notify('No spelling errors found', vim.log.levels.INFO)
  end
end

-- Show spell errors in quickfix
function M.show_spell_errors_quickfix()
  -- Force update spell diagnostics first
  if vim.wo.spell then
    M.update_spell_diagnostics()
    vim.wait(100)
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local namespaces = vim.api.nvim_get_namespaces()
  local spell_ns = namespaces["spell_diagnostics"]

  if not spell_ns then
    vim.notify("Spell diagnostics namespace not found. Make sure spell checking is enabled.", vim.log.levels.WARN)
    return
  end

  local all_diagnostics = vim.diagnostic.get(bufnr, { namespace = spell_ns })

  if #all_diagnostics == 0 then
    vim.notify("No spelling errors found in current buffer", vim.log.levels.INFO)
    return
  end

  -- Show diagnostics in quickfix list
  local qf_list = {}
  for _, diag in ipairs(all_diagnostics) do
    table.insert(qf_list, {
      bufnr = bufnr,
      lnum = diag.lnum + 1,
      col = diag.col + 1,
      text = diag.message,
      type = "I",
    })
  end

  vim.fn.setqflist(qf_list, "r")
  vim.cmd("copen")
end

-- Setup autocmds for spell checking
function M.setup_autocmds()
  vim.api.nvim_create_autocmd({ "CursorHold", "TextChanged", "InsertLeave", "BufEnter" }, {
    callback = M.update_spell_diagnostics,
  })

  -- Initial update
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.defer_fn(M.update_spell_diagnostics, 100)
    end,
  })
end

return M
