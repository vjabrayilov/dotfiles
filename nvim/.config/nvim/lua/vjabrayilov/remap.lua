-- vim.keymap.set("n", "<Space>", "<Nop>", {silent = true})
vim.g.mapleader = " "
-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Up/Down by centering the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Search and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- On Visual Mode paste without losing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Join lines without losing the cursor position
vim.keymap.set("n", "J", "mzJ`z")
-- Copy to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- Copy to the system clipboard but full line
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Delete w/o yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- C-c = Esc
vim.keymap.set("i", "<C-c>", "<Esc>")
-- Q = nop
vim.keymap.set("n", "Q", "<nop>")
-- Format the buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- Prev/Next on quickfix/location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make it rain (garbage)
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
-- Split horizontally/vertically
vim.keymap.set('n', '<C-x>', ':split<CR>')
vim.keymap.set('n', '<C-v>', ':vsplit<CR>')
-- Neogit
vim.keymap.set('n', '<leader>g', ':Neogit<CR>')
-- Save quickly
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')
-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')
-- Open new file adjacent to current file
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- Claude
vim.keymap.set('n', '<leader>c', '<cmd>ClaudeCode<CR>')
