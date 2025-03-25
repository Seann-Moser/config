export GOOGLE_APPLICATION_CREDENTIALS="${HOME}/.config/gcloud/application_default_credentials.json"

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export AWS_DEFAULT_PROFILE=Seann
#flux completion zsh

export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

source <(fzf --zsh)