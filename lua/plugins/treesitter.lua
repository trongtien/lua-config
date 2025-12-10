return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = "true",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "c_sharp",
          "rust",
          "svelte",
          "jsdoc"
        },
        highlight = {
          enable = true,
        },
        sync_install = true,
        auto_install = true,
        indent = {
          enable = true,
        },
      })
    end,
  }
}
