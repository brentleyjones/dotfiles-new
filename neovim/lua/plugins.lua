return require('packer').startup(
  {
    function(use)
      use 'wbthomason/packer.nvim'

      -- Colorschemes
      use 'arzg/vim-colors-xcode'

      -- Languages
      -- use 'sheerun/vim-polyglot'
      -- use 'chiphogg/vim-prototxt'
      use 'keith/swift.vim'

      -- Motions
      -- use 'unblevable/quick-scope'
      use 'justinmk/vim-sneak'

      --
      use 'moll/vim-bbye'
      use 'tpope/vim-eunuch'
      use 'brooth/far.vim'

      -- Editing
      use 'axelf4/vim-strip-trailing-whitespace'
      use {'preservim/nerdcommenter', keys = '<Leader>c'}
      -- use 'karb94/neoscroll.nvim'
      -- use 'tolgraven/proper-smooth.vim'
      use 'psliwka/vim-smoothie'
      use 'aymericbeaumet/vim-symlink'
      use 'junegunn/vim-peekaboo'
      use 'jiangmiao/auto-pairs'
      use 'tpope/vim-surround'
      use 'hrsh7th/nvim-compe'
      use 'hrsh7th/vim-vsnip'
      use 'neovim/nvim-lspconfig'
      use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

      -- Git
      use {'rhysd/git-messenger.vim', cmd = 'GitMessenger', keys = '<Leader>gm'}
      use 'tpope/vim-fugitive'
      use 'tpope/vim-rhubarb'

      -- use 'Yggdroot/indentLine'
      -- use 'lukas-reineke/indent-blankline.nvim'

      if io.popen('uname -m','r'):read('*l') == "arm64" then
        use '/opt/homebrew/opt/fzf'
      else
        use '/usr/local/opt/fzf'
      end
      use 'junegunn/fzf.vim'
    end,
    config = {
      display = {
        -- Display in a floating window
        open_fn = function()
          return require('packer.util').float({ border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } })
        end
      }
    }
  }
)
