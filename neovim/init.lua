if not vim.g.vscode then
  require('plugins')
  require('maps')
  require('settings')
  require('plugin_settings')
else
  require('vscode')
end
