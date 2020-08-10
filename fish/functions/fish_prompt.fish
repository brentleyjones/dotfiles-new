# vim: set noet:
#
# Set the prompt command.

function fish_prompt --description "Write out the prompt"
    set -l last_status $status
    set -l color_cwd
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
        case '*'
            set color_cwd $fish_color_cwd
    end

    set_color normal # clear out anything bold or underline...
    set_color $color_cwd
    echo -ns '❯'
    if test $last_status -eq 0
        echo -ns '❯'
    else
        set_color $fish_color_error
        echo -ns '!'
    end
    set_color $color_cwd
    echo -ns '❯ '
    set_color normal
end
