function setup -d 'Sets initial state for Fish'
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

    # Paths
    set -U fish_user_paths "$HOME/.dotfiles/bin" "/opt/homebrew/bin"

    # Global env variables
    set -Ux EDITOR 'nvim'
    set -Ux BAT_THEME 'GitHub'
    set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

    # Abbreviations
    for abbreviation in (abbr -l)
        abbr -e $abbreviation
    end
    source "$XDG_CONFIG_HOME/fish/functions/set_abbr.fish"

    # Plugins
    curl -sL https://git.io/fisher | source && fisher update

    # Tide configure
    tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='12-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=No
end
