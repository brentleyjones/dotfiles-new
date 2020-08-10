# Checks fetches and checks out the merge commit for a Pull Request
# USAGE: pr <pr number> <branch name> <remote>
pr() {
    REMOTE="${3:-origin}"
    BRANCH="${2:-$1}"
    git fetch "$REMOTE" pull/"$1"/head:"$BRANCH"
    git checkout "$BRANCH"
}
