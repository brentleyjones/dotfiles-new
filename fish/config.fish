set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

set -gx DELTA_PAGER 'less --tabs=4 -RF -+X'

set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git --color=always'
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --ansi'

set -U tide_right_prompt_items status cmd_duration time
set -U tide_git_color_branch F9F9F9
set -U tide_git_color_conflicted F9F9F9
set -U tide_git_color_dirty F9F9F9
set -U tide_git_color_operation F9F9F9
set -U tide_git_color_staged F9F9F9
set -U tide_git_color_stash F9F9F9
set -U tide_git_color_untracked F9F9F9
set -U tide_git_color_upstream F9F9F9
set -U tide_pwd_color_anchors F0F0F0
set -U tide_pwd_color_dirs F0F0F0
set -U tide_time_bg_color EBEBEB

# Stash your environment variables in $XDG_CONFIG_HOME/fish/localconfig.fish.
# This means they'll stay out of your main dotfiles repository (which may be
# public, like this one), but you'll have access to them in your scripts.
if test -e "$XDG_CONFIG_HOME/fish/localconfig.fish"
    source "$XDG_CONFIG_HOME/fish/localconfig.fish"
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

