return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = false,
        lazy = false,
        styles = {
          italic = false,
          disable_background = false
        },
      })
    end
  },
  {
    "bluz71/vim-moonfly-colors",
    enabled = true,
    name = "moonfly",
    lazy = false,
    priority = 1000
  },

  {
    "vague-theme/vague.nvim",
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      vim.cmd("colorscheme vague")
    end
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000
  },
}
