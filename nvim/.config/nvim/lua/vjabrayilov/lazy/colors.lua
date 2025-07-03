return {
    {
        -- "folke/tokyonight.nvim",
        -- config = function()
        --     require("tokyonight").setup({
        --         -- your configuration comes here
        --         -- or leave it empty to use the default settings
        --         style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        --         transparent = true,     -- Enable this to disable setting the background color
        --         terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        --         styles = {
        --             -- Style to be applied to different syntax groups
        --             -- Value is any valid attr-list value for `:help nvim_set_hl`
        --             comments = { italic = false },
        --             keywords = { italic = false },
        --             -- Background styles. Can be "dark", "transparent" or "normal"
        --             sidebars = "dark", -- style for sidebars, see below
        --             floats = "dark",   -- style for floating windows
        --         },
        --     })
        --     vim.cmd("colorscheme delek")
        -- end
        -- Default options:
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                    terminal_colors = true, -- add neovim terminal colors
                --     undercurl = true,
                --     underline = true,
                --     bold = true,
                    italic = {
                        strings = true,
                        emphasis = true,
                        comments = true,
                        operators = false,
                        folds = true,
                    },
                --     strikethrough = true,
                --     invert_selection = false,
                --     invert_signs = false,
                invert_tabline = true,
                --     inverse = false, -- invert background for search, diffs, statuslines and errors
                --     contrast = "",   -- can be "hard", "soft" or empty string
                --     palette_overrides = {},
                --     overrides = {},
                --     dim_inactive = false,
                    transparent_mode = true,
            })
            -- vim.o.background = "light"
            vim.cmd("colorscheme gruvbox")
        end
    },
}
