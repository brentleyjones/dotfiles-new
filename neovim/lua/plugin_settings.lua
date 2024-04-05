local map = vim.api.nvim_set_keymap

-- nvim-comp
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = false;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

map('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
map('i', '<C-e>', 'compe#close("<C-e>")', { noremap = true, silent = true, expr = true })

-- nvim-lspconfig
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = { "clangd", "sourcekit" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  -- ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}

-- vim-bbye
map('n', '<Leader>q', ':Bdelete<CR>', { noremap = true, silent = true })

-- vim-colors-xcode
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
vim.cmd("colorscheme xcodelight")

-- vim-sneak
vim.g["sneak#s_next"] = 1

-- vim-peekaboo
vim.g.peekaboo_window = "vert bo 60new"

-- fzf.vim
map('n', '<Leader>ff', ':Files<CR>', { noremap = true, silent = true })
map('n', '<Leader>fb', ':Buf<CR>', { noremap = true, silent = true })

vim.cmd('command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --follow -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)')

local fzf_colors = {
  fg = { 'fg', 'NormalFloat' },
  bg = { 'bg', 'NormalFloat' },
  border = { 'fg', 'FloatBorder' },
  info = { 'fg', 'Pmenu' },
  prompt = { 'fg', 'Directory' },
  pointer = { 'fg', 'PmenuSel' },
  marker = { 'fg', 'PmenuSel' },
}
fzf_colors['fg+'] = { 'fg', 'PmenuSel' }
fzf_colors['bg+'] = { 'bg', 'PmenuSel' }
fzf_colors['preview-fg'] = { 'fg', 'Normal' }
fzf_colors['preview-bg'] = { 'bg', 'Normal' }
vim.g.fzf_colors = fzf_colors

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.7,
    -- border = 'none',
  }
}
