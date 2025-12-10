return {
    {
        'nvim-telescope/telescope.nvim',
        enabled = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        enabled = false,
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "andrew-george/telescope-themes",
        enabled = false,
        config = function()
            require("telescope").load_extension("themes")
        end,
    },
}
