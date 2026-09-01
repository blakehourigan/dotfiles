set npm_prefix (npm config get prefix)

if status is-interactive
    keychain --eval bitbucket pers_github --agents ssh | source  # set ssh-agent running
    set -gx PATH $npm_prefix/bin $PATH
end
#set -gx N_PREFIX "$HOME/.local/n" idk what this was
