local symbols = Konnor.symbols

return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        build = ":MasonUpdate", -- 更新 mason
        event = "VeryLazy",     -- 延迟加载
        version = "*",
        opts = {
            ui = {
                icons = {
                    package_installed = symbols.Affirmative,
                    package_pending = symbols.Pending,
                    package_uninstalled = symbols.Negative,

                }
            },
            options = {
                -- 使用 nvim_lsp 作为诊断提供工具
                diagnostics = "nvim_lsp",
                -- 诊断指示器函数
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local indicator = " "
                    for level, number in pairs(diagnostics_dict) do
                        local symbol
                        -- 根据诊断级别设置符号
                        if level == "error" then
                            symbol = " "
                        elseif level == "warning" then
                            symbol = " "
                        else
                            symbol = " "
                        end
                        indicator = indicator .. number .. symbol
                    end
                    return indicator
                end
            }
        },
        config = function(_, opts)
            require("mason").setup(opts)

            -- 获取 mason-registry 模块
            local registry = require "mason-registry"
            -- 定义安装包的函数
            local function install(package)
                local s, p = pcall(registry.get_package, package)
                if s and not p:is_installed() then
                    p:install()
                end
            end

            -- 获取 lspconfig 和 mason-lspconfig 的映射关系
            local lspconfig = require "lspconfig"
            local mason_lspconfig_mapping = require("mason-lspconfig").get_mappings().package_to_lspconfig

            -- 获取已安装的包列表
            local installed_packages = registry.get_installed_package_names()

            -- 遍历配置的 LSP 服务器
            for lsp, config in pairs(Konnor.lsp) do
                -- 如果 LSP 未启用，跳过
                -- if not config.enabled then
                --     goto continue
                -- end
                if lsp == "rust" then
                    goto continue
                end

                -- 获取格式化工具并安装 LSP 和格式化工具
                local formatter = config.formatter
                install(lsp)
                install(formatter)

                -- 如果 LSP 未安装，跳过
                if not vim.tbl_contains(installed_packages, lsp) then
                    goto continue
                end

                -- 获取 LSP 的实际名称
                lsp = mason_lspconfig_mapping[lsp]
                -- 如果 LSP 不是由插件管理且存在配置
                if not config.managed_by_plugin and lspconfig[lsp] ~= nil then
                    -- 获取 LSP 配置
                    local setup = config.setup
                    if type(setup) == "function" then
                        setup = setup()
                    elseif setup == nil then
                        setup = {}
                    end

                    -- 设置 LSP 功能
                    local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
                    blink_capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    }
                    setup = vim.tbl_deep_extend("force", setup, {
                        capabilities = blink_capabilities,
                    })

                    -- 设置 LSP
                    lspconfig[lsp].setup(setup)
                end
                ::continue::
            end

            -- 配置诊断设置
            vim.diagnostic.config {
                update_in_insert = true,
                severity_sort = true, -- 必须启用以使 lspsaga 的 show_line_diagnostics 正常工作
                virtual_text = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = symbols.Error,
                        [vim.diagnostic.severity.WARN] = symbols.Warn,
                        [vim.diagnostic.severity.HINT] = symbols.Hint,
                        [vim.diagnostic.severity.INFO] = symbols.Info,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    },
                    texthl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    },
                },
            }

            -- 启用内联提示
            vim.lsp.inlay_hint.enable()

            -- 启动 LSP
            vim.cmd "LspStart"
        end,
    }
}
