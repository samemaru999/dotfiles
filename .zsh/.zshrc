# asdf #
. /opt/homebrew/opt/asdf/libexec/asdf.sh    # source = . 

# gcloud-cli #
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# GitHub-cli #
eval "$(gh completion -s zsh)"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
