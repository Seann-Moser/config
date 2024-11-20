eval "$(starship init zsh)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'


source ~/.config/zsh/antigen.zsh

source /usr/share/nvm/init-nvm.sh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

antigen use oh-my-zsh
antigen bundle git
antigen bundle command-not-found

antigen apply


# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/n2b/google-cloud-sdk/path.zsh.inc' ]; then . '/home/n2b/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/n2b/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/n2b/google-cloud-sdk/completion.zsh.inc'; fi


for file in ~/.zsh_config/*; do
    source "$file"
done

# bun completions
[ -s "/home/n2b/.bun/_bun" ] && source "/home/n2b/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
