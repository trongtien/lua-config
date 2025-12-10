return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Enable completion capabilities for auto-import
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }
    -- local lspconfig = require('lspconfig')

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT', -- Use LuaJIT for Neovim
          },
          diagnostics = {
            globals = { 'vim' }, -- Recognize `vim` as a global
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true), -- Make LSP aware of Neovim runtime
            checkThirdParty = false,                           -- Disable third-party library warnings
          },
          telemetry = {
            enable = false, -- Disable telemetry for privacy
          },
        },
      },
    })

    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
            autoImports = true,
          },
          preferences = {
            importModuleSpecifier = "relative",
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
            autoImports = true,
          },
          preferences = {
            importModuleSpecifier = "relative",
          },
        },
      },
    })

    vim.lsp.config("clangd", {})
    vim.lsp.config("rust_analyzer", {
      -- cmd = { "/home/ricardo/.cargo/bin/rust-analyzer" }
    })
    vim.lsp.config("clangd", {})
    vim.lsp.config("jsonls", {})
    vim.lsp.config("powershell_es", {})
    vim.lsp.config("astro", {})
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
       filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "heex" }
    })
    vim.lsp.config("svelte", {
      capabilities = capabilities,
      settings = {
        svelte = {
          plugin = {
            svelte = {
              compilerWarnings = {
                ["a11y-click-events-have-key-events"] = "ignore",
              },
            },
          },
          enableTsPlugin = true,
          -- Enable Svelte 5 features
          compilerOptions = {
            runes = true,
          },
        },
        typescript = {
          suggest = {
            autoImports = true,
          },
          preferences = {
            importModuleSpecifier = "relative",
          },
        },
      },
    })

    print("Configuring servers")

    vim.lsp.config("lemminx", {
      filetypes = { "xml", "axaml", "xsd", "xslt", "csproj" },
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.axaml",
      callback = function()
        vim.bo.filetype = "xml"
      end,
    })
  end
}
