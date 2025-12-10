return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = {
                    indent = {
                        middle = " ",
                        last = " ",
                        top = " ",
                        ws = "│  ",
                    },
                },
                use_diagnostic_signs = true,
                modes = {
                    diagnostics = {
                        auto_open = false,
                        auto_close = false,
                        auto_preview = true,
                        auto_refresh = true,
                        focus = false,
                    },
                },
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle("diagnostics")
            end, { desc = "Toggle Trouble Diagnostics" })

            vim.keymap.set("n", "<leader>tw", function()
                require("trouble").toggle("workspace_diagnostics")
            end, { desc = "Workspace Diagnostics" })

            vim.keymap.set("n", "<leader>td", function()
                require("trouble").toggle("document_diagnostics")
            end, { desc = "Document Diagnostics" })

            vim.keymap.set("n", "nt", function()
                require("trouble").next({skip_groups = true, jump = true});
            end, { desc = "Next Trouble Item" })

            vim.keymap.set("n", "pt", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end, { desc = "Previous Trouble Item" })

        end
    },
}

