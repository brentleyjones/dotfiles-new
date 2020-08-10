# Stash your environment variables in ~/.config/fish/localconfig.fish.
# This means they'll stay out of your main dotfiles repository (which may be
# public, like this one), but you'll have access to them in your scripts.
if test -e "$HOME/.config/fish/localconfig.fish"
    source "$HOME/.config/fish/localconfig.fish"
end
