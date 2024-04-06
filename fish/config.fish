set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"

set -gx DELTA_PAGER 'less --tabs=4 -RF -+X'

set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git --color=always'
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --ansi'

set -g fish_greeting

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

# abbr

abbr -a -- 8601 'date -u +%Y-%m-%dT%H:%M:%SZ'
abbr -a -- bz 'bazel'
abbr -a -- deeplink 'xcrun simctl openurl booted'
abbr -a -- g git
abbr -a -- gaa 'git add .'
abbr -a -- gc 'git commit'
abbr -a -- gca 'git commit --amend --no-edit'
abbr -a -- gcaa 'git commit --amend --no-edit -a'
abbr -a -- gcf 'git commit --fixup'
abbr -a -- gco 'git checkout'
abbr -a -- gcp 'git cherry-pick'
abbr -a -- gcpc 'git cherry-pick --continue'
abbr -a -- gcps 'git cherry-pick --skip'
abbr -a -- gdm 'git delete-local-merged'
abbr -a -- gf 'git fetch --all'
abbr -a -- gfp 'git push --force-with-lease'
abbr -a -- gmt 'git mergetool'
abbr -a -- gpr 'git submit-pr'
abbr -a -- gr 'git rebase'
abbr -a -- gra 'git rebase --abort'
abbr -a -- grc 'git rebase --continue'
abbr -a -- gri 'git rebase -i'
abbr -a -- gro 'git rebase --onto'
abbr -a -- grs 'git rebase --skip'
abbr -a -- gs 'git show'
abbr -a -- gup 'git update-pr'
abbr -a -- ll 'ls -lhA'

# Stash your environment variables in $XDG_CONFIG_HOME/fish/localconfig.fish.
# This means they'll stay out of your main dotfiles repository (which may be
# public, like this one), but you'll have access to them in your scripts.
if test -e "$XDG_CONFIG_HOME/fish/localconfig.fish"
    source "$XDG_CONFIG_HOME/fish/localconfig.fish"
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

