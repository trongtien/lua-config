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

            vim.keymap.set("n", "<leader>ta", function()
                require("trouble").toggle("diagnostics")
            end, { desc = "Toggle Trouble all Diagnostics" })

            vim.keymap.set("n", "<leader>tw", function()
                require("trouble").toggle({
                    mode = "diagnostics",
                    filter = { severity = vim.diagnostic.severity.WARN },
                })
            end, { desc = "Toggle Trouble Warnings" })

            vim.keymap.set("n", "<leader>te", function()
                require("trouble").toggle({
                    mode = "diagnostics",
                    filter = { severity = vim.diagnostic.severity.ERROR },
                })
            end, { desc = "Toggle Trouble Errors" })

            vim.keymap.set("n", "<leader>ts", function()
                require("utils.util_spell").show_spell_errors_quickfix()
            end, { desc = "Show Spell Check in Quickfix" })

            vim.keymap.set("n", "nt", function()
                require("trouble").next({skip_groups = true, jump = true});
            end, { desc = "Next Trouble Item" })

            vim.keymap.set("n", "pt", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end, { desc = "Previous Trouble Item" })

        end
    },
}

