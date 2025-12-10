return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        debounce = 75,  -- Reduce delay for suggestions (default 75ms)
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {},
    keys = {
      { "<leader>cc", "<Cmd>CopilotChat<CR>",             mode = { "n", "v" }, desc = "Chat with Copilot" },
      { "<leader>ce", "<Cmd>CopilotChatExplain<CR>",      mode = { "n", "v" }, desc = "Explain Code" },
      { "<leader>cr", "<Cmd>CopilotChatReview<CR>",       mode = { "n", "v" }, desc = "Review Code" },
      { "<leader>cf", "<Cmd>CopilotChatFix<CR>",          mode = { "n", "v" }, desc = "Fix Code Issues" },
      { "<leader>co", "<Cmd>CopilotChatOptimize<CR>",     mode = { "n", "v" }, desc = "Optimize Code" },
      { "<leader>cd", "<Cmd>CopilotChatDocs<CR>",         mode = { "n", "v" }, desc = "Generate Docs" },
      { "<leader>ct", "<Cmd>CopilotChatTests<CR>",        mode = { "n", "v" }, desc = "Generate Tests" },
      { "<leader>cs", "<Cmd>CopilotChatSuggest<CR>",      mode = { "n", "v" }, desc = "Suggest Code" },
      { "<leader>cm", "<Cmd>CopilotChatCommit<CR>",       mode = { "n", "v" }, desc = "Generate Commit Message" },
      { "<leader>ca", "<Cmd>CopilotChatCommitStaged<CR>", mode = { "n", "v" }, desc = "Generate Commit for Selection" },
    }
  }
}
