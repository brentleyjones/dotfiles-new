return require('packer').startup(
  {
    function(use)
      use 'wbthomason/packer.nvim'

      -- Editing
      use 'tpope/vim-surround'
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
