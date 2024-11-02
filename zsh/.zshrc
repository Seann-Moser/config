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
