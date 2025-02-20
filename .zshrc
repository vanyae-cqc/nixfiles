# ZSH configuration

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"


# Path to your oh-my-zsh installation.
export ZSH="/Users/vanya.eccles/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="essembeh"

source $ZSH/oh-my-zsh.sh

# User configuration

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

# Poetry requirement
fpath+=~/.zfunc
autoload -Uz compinit && compinit


# param alias to run standard python pre-commit tools
fmt() {
    poetry run black $1 && poetry run pylint $1 && poetry run mypy $1 --namespace-packages
}

# alias for starting poetry env from within poetry project
poetrysh() {
    source $(poetry env info --path)/bin/activate
}

# direnv hook
eval "$(direnv hook zsh)"

alias cat='bat --paging=never'

eval "$(starship init zsh)"
