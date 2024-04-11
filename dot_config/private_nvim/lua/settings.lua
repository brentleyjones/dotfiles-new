-- Map the leader key to <Space>
vim.api.nvim_set_keymap("n", "<Space>", "", {})
vim.g.mapleader = " "

-- Disable double spaces with join
vim.opt.joinspaces = true

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Allow placing cursor after the end of newline
vim.opt.virtualedit = "onemore"

-- Everything below this line is only applied if not running in VS Code
if vim.g.vscode then
    return
end

-- 24-bit colors
vim.opt.termguicolors = true

-- Cursor blink
vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
    "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
    "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

-- Show line numbers
vim.wo.number = true

-- Show sign column (gutter space for LSP info)
vim.wo.signcolumn = "yes"

-- Show last newline
vim.opt.fixendofline = true

-- Highlight all search results
vim.opt.hlsearch = true

-- Show subsitutions in place
vim.opt.inccommand = "nosplit"

-- Show search results as you type
vim.opt.incsearch = true

-- Create a vertical split below the current pane
vim.opt.splitbelow = true

-- Create a horizontal split to the right of the current pane
vim.opt.splitright = true

-- Use Ripgrep for :grep
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

-- Ignore case in filenames
vim.opt.fileignorecase = true

-- Indentation
vim.bo.expandtab = true

-- Scroll wrapped lines better
vim.o.smoothscroll = true
