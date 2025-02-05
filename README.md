## Stow
`.stow-local.ignore` is a file that contains a list of files that should be ignored by stow.
## Neovim

Some about configuration goes here

### Plugins

1. [blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
 - Adds indentation guides to Neovim
2. [cloak](https://github.com/laytan/cloak.nvim?tab=readme-ov-file)
 - Masks secrets in environment files
3. colors
 - Uses [Tokyonight](https://github.com/folke/tokyonight.nvim) theme
4. [comment](https://github.com/numToStr/Comment.nvim)
 - Powerful comment tool
5. [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
 - Mark additions/removal on the left side
 - Git blame
 >TODO: add keymaps for this
6. [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
 - Marks files and allows you to quickly switch between them
 - `<leader>a` adds file to harpoon
 - `<C-e>` toggles harpoon menu
7. [illuminate](https://github.com/RRethy/vim-illuminate)
 - Highlights word under cursor
8. [iron](https://github.com/Vigemus/iron.nvim)
 - REPL manager
 - No need currently, but good to improve here...
9. LSP
 -
10. [lualine](https://github.com/nvim-lualine/lualine.nvim)
 - Adds a nice status line
11. [neogen](https://github.com/danymat/neogen)
 - Generates code for docstrings
 - `<leader>nf` to generate for function
 - `<leader>nt` to generate for type
12. [neogit](https://github.com/NeogitOrg/neogit)
 - Magit alternative
13. [neotest](https://github.com/nvim-neotest/neotest)
 - Interact with tests
 - `<leader>tc` to run all tests
 - `<leader>tf` to run current test
14. [nvim-surround](https://github.com/kylechui/nvim-surround)
 - Add/change/delete surrounding delimiter with ease
 - TOOD: link with notes above for keymaps...
15. [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
 - Supercharges Rust experience
 - Master this!
16. [snippets](https://github.com/L3MON4D3/LuaSnip)
 - Snippet engine
 - TODO: needs work and mastery
17. [telescope](https://github.com/nvim-telescope/telescope.nvim)
 - Find/Filter/Preview/Pick
 - `<leader>ff` to find files
 - `<leader>fl` to live grep
 - `<leader>fb` to find buffers
 - `<leader>fh` to find help tags
 - `<leader>fws` to find word under cursor
 - `<leader>fWs` to combination under cursor
18. [todo](https://github.com/folke/todo-comments.nvim)
 - Higlight/list/search todo comments in the project
 - TODO: add keymaps for ToC
19. [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
 - Abstraction layer for parser generator
20. [trouble](https://github.com/folke/trouble.nvim)
 - Pretty diagnostics
 - `<leader>tt` to toggle trouble
 - `<leader>tT` to toggle trouble for buffer
 - `<leader>ts` to toggle symbol list
 - `<leader>td` to toggle definition/reference list
 - `<leader>tl` to toggle loclist
 - `<leader>tq` to toggle quickfix list
21. [undotree](https://github.com/mbbill/undotree)
 - Visualize undo tree
 - `<leader>u` to toggle undotree
22. [vim-tmux](https://github.com/christoomey/vim-tmux-navigator)
 - Seamless navigation between tmux and vim
23.



### vim-surround
    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

- `ys{motion}{char}`, which surrounds a given |motion| or |text-object| with a
delimiter pair associated with {char}. For example, `ysa")` means "you surround
around quotes with parentheses".

- There are insert-mode *<C-g>s* and visual-mode *S* mappings, that
add the delimiter pair around the cursor and visual selection, respectively.

- To delete a delimiter pair, use the *ds* operator, which stands for "delete
surround". It is used via `ds[char]`.

- To change a delimiter pair, use the *cs* operator, which stands for "change
surround". It is used via `cs{target}{replacement}`, changing the surrounding
pair associated with {target} to a pair associated with {replacement}.

Learn more [here](https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt_).

### comment
- Normal mode
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
- Visual mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment

- Advanced mappings
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode
#### Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5j` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

#### Blockwise

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)

## fzf
Make the following table
Table markdown 2 columns
Example | Description
CTRL-t |	Look for files and directories
CTRL-r |	Look through command history
Enter  |	Select the item
Ctrl-j or Ctrl-n or Down arrow |	Go down one result
Ctrl-k or Ctrl-p or Up arrow |	Go up one result
Tab |	Mark a result
Shift-Tab |	Unmark a result
cd `**Tab` |	Open up fzf to find directory
export `**Tab` |	Look for env variable to export
unset `**Tab`	Look | for env variable to unset
unalias `**Tab` |	Look for alias to unalias
ssh `**Tab` |	Look for recently visited host names
kill -9 `**Tab` | Look for process name to kill to get pid
any command (like nvim or code) + `**Tab` |	Look for files & directories to complete command

<!-- TODO: automate installing the following
    fd
    fzf-git
     - git clone to the $HOME
    bat

-->
## fzf-git
Keybinding |	Description
CTRL-GF | 	Look for git files with fzf
CTRL-GB | 	Look for git branches with fzf
CTRL-GT | 	Look for git tags with fzf
CTRL-GR | 	Look for git remotes with fzf
CTRL-GH | 	Look for git commit hashes with fzf
CTRL-GS | 	Look for git stashes with fzf
CTRL-GL | 	Look for git reflogs with fzf
CTRL-GW | 	Look for git worktrees with fzf
CTRL-GE | 	Look for git for-each-ref with fzf
