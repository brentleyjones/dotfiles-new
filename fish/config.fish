set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git --color=always'
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --ansi'

# Stash your environment variables in $XDG_CONFIG_HOME/fish/localconfig.fish.
# This means they'll stay out of your main dotfiles repository (which may be
# public, like this one), but you'll have access to them in your scripts.
if test -e "$XDG_CONFIG_HOME/fish/localconfig.fish"
    source "$XDG_CONFIG_HOME/fish/localconfig.fish"
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

