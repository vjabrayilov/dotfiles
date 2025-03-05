return {
    "ggandor/leap.nvim",
    config = function()
        require("leap").create_default_mappings()
    end,
    vim.keymap.set({'n', 'x', 'o'}, '<C-s>', '<Plug>(leap-backward)')
}
