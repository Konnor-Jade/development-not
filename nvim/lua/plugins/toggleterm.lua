return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        open_mapping = [[<c-\>]],
        direction = 'horizontal',
        start_in_insert = true,
    },
    config = function()
        require('toggleterm').setup()
    end,
}
