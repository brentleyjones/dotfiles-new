-- Use a custom `opt()` until https://github.com/neovim/neovim/pull/13479 lands
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-------------------------------------------------------------------------------
-- Navigation
-------------------------------------------------------------------------------

-- Allow modified buffers to become hidden
opt('o', 'hidden', true)

-- Mouse
vim.cmd('set mouse=n')

-- Show search results as you type
opt('o', 'incsearch', true)

-- Ignore case in filenames
opt('o', 'fileignorecase', true)

-- Fix wildmenu navigation
vim.cmd([[
  set wildcharm=<C-Z>
  cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
  cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
  cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
  cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
]])

-------------------------------------------------------------------------------
-- Visual
-------------------------------------------------------------------------------

-- 24-bit colors
vim.cmd("set termguicolors")

-- Cursor blink
vim.cmd('set guicursor+=a:blinkon100')

-- Show whitespace
-- opt('w', 'listchars', 'space:·,tab:→ ')
-- opt('w', 'list', true)

-- Show line numbers
opt('w', 'number', true)
-- Relative line numbers
-- opt('w', 'relativenumber', true)

-- Show sign column
opt('w', 'signcolumn', 'yes')

-- Highlight all search results
opt('o', 'hlsearch', true)
-- Show subsitutions in place
opt('o', 'inccommand', 'nosplit')

-- Highlight current line, only in current window
-- opt('w', 'cursorline', true)
vim.cmd([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]])

-------------------------------------------------------------------------------
-- Editing
-------------------------------------------------------------------------------

-- Indentation
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 2)
-- vim.g.indentLine_char = '▏'
-- vim.g.indent_blankline_char = '▏'

vim.cmd('filetype plugin on')
vim.g.NERDSpaceDelims = 1

--- Disable double spaces with join
opt('o', 'joinspaces', true)

-- Completion
opt('o', 'completeopt', 'menuone,noselect')

-- System clipboard
opt('o', 'clipboard', 'unnamedplus')

------------------------------------------------------------------------------
-- Windows
-------------------------------------------------------------------------------

-- create a vertical split below the current pane
opt('o', 'splitbelow', true)
-- create a horizontal split to the right of the current pane
opt('o', 'splitright', true)

-- Always open Quickfix list below all other windows
vim.cmd('autocmd FileType qf wincmd J')

-- Reload plugins after editing plugins.lua
vim.cmd([[
  autocmd BufWritePost ~/.dotfiles/neovim/lua/plugins.lua luafile ~/.dotfiles/neovim/lua/plugins.lua
  autocmd BufWritePost ~/.dotfiles/neovim/lua/plugins.lua PackerSync
]])

-- Use Ripgrep for :grep
opt('o', 'grepprg', 'rg --vimgrep --no-heading --smart-case --follow --glob "!.git/*"')
opt('o', 'grepformat', '%f:%l:%c:%m,%f:%l:%m')

-- Use system clipboard
-- I don't know why this is not the default option. I am missing something.
-- TODO: Figure out a better way to copy to system clipboard and paste from
-- system clipboard.
-- TODO: I think when we do `set clipboard+=unnamedplus`, it's not concatenating
-- the string 'unnamedplus' to the option clipboard. It's add another value to
-- some object probably
