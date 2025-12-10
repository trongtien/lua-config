return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>c", group = "Copilot Chat", mode = { "n", "v" } },
      { "<leader>t", group = "Trouble", mode = { "n" } },
      { "<leader>s", group = "Spell Check", mode = { "n" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>P",
      function()
        require("snacks").picker.lazy()
      end,
      desc = "Plugins (Snacks)",
    },
  },
}
