return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local indicator = " "
                for level, number in pairs(diagnostics_dict) do
                    local symbol
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
    keys = {
        { "<leader>bp", ":BufferLineCyclePrev<CR>", desc = "跳转上一个 buffer", silent = true },
        { "<leader>bn", ":BufferLineCycleNext<CR>", desc = "跳转下一个 buffer", silent = true },
        { "<leader>bd", ":bdelete<CR>", desc = "删除当前 buffer", silent = true },
        { "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "关闭其他 buffer", silent = true },
        { "<leader>bp", ":BufferLinePick<CR>", desc = "选择 buffer", silent = true },
        { "<leader>bc", ":BufferLinePickClose<CR>", desc = "选择关闭 buffer", silent = true },
    },
}
