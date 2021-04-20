local map = vim.api.nvim_set_keymap

-- Map the leader key to <Space>
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- Disable arrow keys
map('', '<Up>', '<NOP>', { noremap = true })
map('', '<Down>', '<NOP>', { noremap = true })
map('', '<Left>', '<NOP>', { noremap = true })
map('', '<Right>', '<NOP>', { noremap = true })

-- TODO: Consider nnoremap <nowait><silent> <C-C> :noh<CR>
