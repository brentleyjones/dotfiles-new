-- Use a custom `opt()` until https://github.com/neovim/neovim/pull/13479 lands
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-------------------------------------------------------------------------------
-- Editing
-------------------------------------------------------------------------------

--- Disable double spaces with join
opt('o', 'joinspaces', true)

-- System clipboard
opt('o', 'clipboard', 'unnamedplus')
