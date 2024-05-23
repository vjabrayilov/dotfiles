## Stow
`.stow-local.ignore` is a file that contains a list of files that should be ignored by stow.
## Neovim
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
# Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5j` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)
