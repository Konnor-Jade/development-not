vim.api.nvim_create_autocmd("User", {
    pattern = "KonnorAfter nvim-treesitter",
    callback = function()
        print("hello world")
    end
})
