return {
  "frenchef156/harpoon-lists.nvim",
 dependencies = {
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
    },
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local harpoonLists = require("harpoon-lists")

    -- REQUIRED
    harpoonLists:setup()
    -- REQUIRED


    vim.keymap.set("n", "<leader>ha", function() harpoonLists:list():add() end,
      { desc = "Add current file to Harpoon list" })
    vim.keymap.set("n", "<leader>hr", function() harpoonLists:list():remove() end,
      { desc = "Remove current file from Harpoon list" })
    vim.keymap.set("n", "<leader>hs", function() harpoonLists.harpoon.ui:toggle_quick_menu(harpoonLists:list()) end,
      { desc = "Toggle Harpoon list" })

    vim.keymap.set("n", "<M-1>", function() harpoonLists:list():select(1) end,
      { desc = "Select first buffer in Harpoon list" })
    vim.keymap.set("n", "<M-2>", function() harpoonLists:list():select(2) end,
      { desc = "Select second buffer in Harpoon list" })
    vim.keymap.set("n", "<M-3>", function() harpoonLists:list():select(3) end,
      { desc = "Select third buffer in Harpoon list" })
    vim.keymap.set("n", "<M-4>", function() harpoonLists:list():select(4) end,
      { desc = "Select fourth buffer in Harpoon list" })
    vim.keymap.set("n", "<M-5>", function() harpoonLists:list():select(5) end,
      { desc = "Select fifth buffer in Harpoon list" })
    vim.keymap.set("n", "<M-6>", function() harpoonLists:list():select(6) end,
      { desc = "Select sixth buffer in Harpoon list" })
    vim.keymap.set("n", "<M-7>", function() harpoonLists:list():select(7) end,
      { desc = "Select seventh buffer in Harpoon list" })
    vim.keymap.set("n", "<M-8>", function() harpoonLists:list():select(8) end,
      { desc = "Select eighth buffer in Harpoon list" })
    vim.keymap.set("n", "<M-9>", function() harpoonLists:list():select(9) end,
      { desc = "Select ninth buffer in Harpoon list" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function() harpoonLists:list():prev({ ui_nav_wrap = true }) end,
      { desc = "Go to previous buffer in Harpoon list" })
    vim.keymap.set("n", "<leader>hn", function() harpoonLists:list():next({ ui_nav_wrap = true }) end,
      { desc = "Go to next buffer in Harpoon list" })
  end
}
