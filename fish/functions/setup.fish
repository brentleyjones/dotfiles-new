function setup -d 'Sets initial state for Fish'
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

    # Paths
    set -U fish_user_paths "$HOME/.dotfiles/bin"

    # Global env variables
    set -Ux EDITOR 'code -w'
    set -Ux BAT_THEME 'GitHub'

    # Abbreviations
    for abbreviation in (abbr -l)
        abbr -e $abbreviation
    end
    source "$XDG_CONFIG_HOME/fish/functions/set_abbr.fish"

    # Plugins
    curl -sL https://git.io/fisher | source && fisher update
end
