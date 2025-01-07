alias nv="nvim"

# Filepath
alias cdp='cd ~/projects/github.com/'
alias cds='cd ~/go/src/github.com/Seann-Moser'
alias cdh='cd ~/go/src/github.com/HiroCloud'
alias cdhf='cd ~/go/src/github.com/HiroCloud/k8s-flux'
alias cdps='cd ~/go/src/github.com/Stodge-Inc/'

alias runAccess='chmod 777'

# ZSH
alias refresh="source ~/.zshrc"

alias kubectl-cleanup-pods='kubectl get pods --all-namespaces | grep -E "Evicted|ContainerStatusUnknown" | awk "{print \$1 \" \" \$2}" | xargs -n2 sh -c "kubectl delete pod \$1 -n \$0"'
# Docker
alias dcud='docker compose up -d'
alias dcub='docker compose up --build'

alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && brew update && brew upgrade && flatpak update'
alias eip='dig +short myip.opendns.com @resolver1.opendns.com'

#alias psinit='bash ${HOME}/.oh-my-zsh/custom/psinit.sh'
alias cloudsql='cloud-sql-proxy --port 3306 surveynoodle:us-west1:surveynoodle-main'
alias bambu='__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json WEBKIT_DISABLE_DMABUF_RENDERER=1 WEBKIT_FORCE_COMPOSITING_MODE=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 bambu-studio'

alias steam='gamemoderun steam'