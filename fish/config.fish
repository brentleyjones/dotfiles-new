set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

# Stash your environment variables in $XDG_CONFIG_HOME/fish/localconfig.fish.
# This means they'll stay out of your main dotfiles repository (which may be
# public, like this one), but you'll have access to them in your scripts.
if test -e "$XDG_CONFIG_HOME/fish/localconfig.fish"
    source "$XDG_CONFIG_HOME/fish/localconfig.fish"
end
