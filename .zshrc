# Load usefull fonctions
autoload -Uz compinit colors

# Homebrew auto-completion (Homebrew zsh-completions formula required)
fpath=(/usr/local/share/zsh-completions $fpath)

# Default to standard emacs bindings (vi for Vim)
bindkey -e

# Open new tabs in same directory
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  function chpwd {
    printf '\e]7;%s\a' "file://$HOSTNAME${PWD// /%20}"
  }
  chpwd
fi


# ============ SMART COMPLETION ============ #

compinit
setopt complete_in_word   # Allow completion from within a word/phrase
setopt completealiases    # Complete aliases
setopt always_to_end      # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_cd            # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
# setopt correct_all      # Autocorrect commands

# Enable completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# List of completers to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

zstyle ':completion:*' menu select

# Match uppercase from lowercasethen match both
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Formatting and messages
zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''


# ============ HISTORY ============ #

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt share_history         # Share hist between sessions
setopt extended_history      # Save timestamp of command and duration
setopt inc_append_history    # Add comamnds as they are typed, don't wait until shell exit
setopt hist_ignore_all_dups  # No duplicate
setopt hist_reduce_blanks    # Trim blanks
setopt hist_verify           # Show before executing history commands

# Smart history completion
bindkey "\e[B"      history-search-forward    # Down arrow
bindkey "\e[A"      history-search-backward   # Up arrow


# ============ PROMPT ============ #

# export TERM="xterm-256color"

colors
setopt prompt_subst     # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt

source ~/.zsh/git-prompt.zsh # script adapted from https://github.com/woefe/git-prompt.zsh

PROMPT='%F{red}%1~%f$(gitprompt) %(?.%F{white}❯%f.%F{red}❯%f) '
RPROMPT='%B%F{red}%T%f%b'


# ============ ALIASES ============ #

alias grep='grep --color=auto'

# Add file type indicator, enable color and put sizes in human readable format
alias ls='ls -FGh'
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
