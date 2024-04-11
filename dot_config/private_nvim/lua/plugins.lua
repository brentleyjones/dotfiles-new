local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Download `lazy.nvim` if needed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

-- Add `lazy.nvim` to the runtime path
vim.opt.runtimepath:prepend(lazypath)

-- Configure `lazy.nvim`
local plugins = {}

if not vim.g.vscode then
    plugins = vim.tbl_extend("error", plugins, {
        {
            "lunacookies/vim-colors-xcode",
            lazy = false, -- Main colorscheme, load during startup
            priority = 1000, -- Load before all the other start plugins
            config = function()
                -- Additional colors
                vim.cmd([[
augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight MatchParen cterm=bold ctermbg=none ctermfg=none gui=bold guibg=none guifg=none
    autocmd ColorScheme * highlight FloatBorder guibg=#f4f4f4
    autocmd InsertEnter * highlight CursorLine guibg=#f7effc
    autocmd InsertEnter * highlight CursorLineNr ctermfg=130 guifg=#262626 guibg=#f7effc
    autocmd InsertEnter * highlight CursorColumn ctermbg=7 guibg=#f7effc
    autocmd InsertLeave * highlight CursorLine guibg=#ecf5ff
    autocmd InsertLeave * highlight CursorLineNr ctermfg=130 guifg=#262626 guibg=#ecf5ff
    autocmd InsertLeave * highlight CursorColumn ctermbg=7 guibg=#ecf5ff
augroup END
                ]])

                -- Load colorscheme
                vim.cmd([[colorscheme xcodelight]])
            end,
        },
        {
            "cappyzawa/trim.nvim",
            opts = {
                -- Highlight trailing spaces
                highlight = true,
            },
        },
    })
end

require("lazy").setup(plugins)
