local lsp = {}

-- For instructions on configuration, see official wiki:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
lsp = {
    ["bash-language-server"] = {
        formatter = "shfmt",
    },
    clangd = {},
    ["css-lsp"] = {
        formatter = "prettier",
        setup = {
            settings = {
                css = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
                less = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
                scss = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
            },
        },
    },
    ["emmet-ls"] = {
        setup = {
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
        },
    },

    gopls = {
        enabled = true,
        formatter = "gofumpt",
        setup = {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    usePlaceholders = true,
                    experimentalPostfixCompletions = true,
                    completion = {
                        usePlaceholders = true, -- 使用占位符
                        completionBudget = "500ms",
                        matcher = "fuzzy",
                        completionUnimported = true,
                    },
                },
            },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            capabilities = {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                            preselectSupport = true,
                            insertReplaceSupport = true,
                            labelDetailsSupport = true,
                            deprecatedSupport = true,
                            commitCharactersSupport = true,
                            tagSupport = { valueSet = { 1 } },
                            resolveSupport = {
                                properties = {
                                    "documentation",
                                    "detail",
                                    "additionalTextEdits",
                                }
                            },
                        },
                    },
                },
            },
        },
    },
    ["html-lsp"] = {
        formatter = "prettier",
    },
    ["json-lsp"] = {
        formatter = "prettier",
    },
    ["lua-language-server"] = {
        formatter = "stylua",
        setup = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = (function()
                            local runtime_path = vim.split(package.path, ";")
                            table.insert(runtime_path, "lua/?.lua")
                            table.insert(runtime_path, "lua/?/init.lua")
                            return runtime_path
                        end)(),
                    },
                    diagnostics = {
                        globals = { "vim", "Konnor" },
                    },
                    hint = {
                        enable = true,
                    },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library",
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
        enabled = true,
    },
    omnisharp = {
        formatter = "csharpier",
        setup = {
            cmd = {
                "dotnet",
                vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/Omnisharp.dll",
            },
            on_attach = function(client, _)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        },
    },
    pyright = {
        formatter = "black",
    },
    rust = {
        managed_by_plugin = true,
    },
    tinymist = {
        formatter = "typstfmt",
        setup = {
            single_file_support = true,
        },
    },
    ["typescript-language-server"] = {
        formatter = "prettier",
        setup = {
            single_file_support = true,
            flags = lsp.flags,
            on_attach = function(client)
                if #vim.lsp.get_clients { name = "denols" } > 0 then
                    client.stop()
                end
            end,
        },
    },
}

Konnor.lsp = lsp
