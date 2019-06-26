# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/home/nwprince/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install


source ~/.dotfiles/.env
[[ $- != *i* ]] && return

source ~/.dotfiles/antibody/.zsh_plugins.sh
source ~/.dotfiles/.alias
source ~/.dotfiles/.functions
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Prompt Config
SPACESHIP_PROMPT_ORDER=(
dir           # Current directory section
git_branch    # Git section (git_branch + git_status)
exec_time     # Execution time
line_sep      # Line break
jobs          # Background jobs indicator
venv          # virtualenv section
char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
user
host
)

SPACESHIP_CHAR_SYMBOL=""
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_COLOR_SUCCESS="magenta"

SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_LOCK_SYMBOL="  "
SPACESHIP_DIR_PREFIX=" "

SPACESHIP_USER_SHOW="true"
SPACESHIP_USER_SUFFIX=""

SPACESHIP_HOST_SHOW="true"
SPACESHIP_HOST_PREFIX="@"

SPACESHIP_GIT_BRANCH_SYMBOL=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="242"
SPACESHIP_GIT_STATUS_MODIFIED="*"
SPACESHIP_GIT_STATUS_AHEAD="↑"
SPACESHIP_GIT_STATUS_BEHIND="↓"
SPACESHIP_GIT_STATUS_DIVERGED="⇅"

SPACESHIP_EXEC_TIME_PREFIX=""
SPACESHIP_EXEC_TIME_ELAPSED="5"

SPACESHIP_VENV_PREFIX=""
SPACESHIP_VENV_COLOR="242"
