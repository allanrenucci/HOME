# Load usefull fonctions
autoload -Uz compinit colors

# Homebrew auto-completion (Homebrew zsh-completions formula required)
fpath=(/usr/local/share/zsh-completions $fpath)

# Default to standard emacs bindings (vi for Vim)
bindkey -e

# Open new tabs in the same directory
precmd() { print -Pn "\e]2; %~/ \a" }
preexec() { print -Pn "\e]2; %~/ \a" }

# ============ SMART COMPLETION ============ #

compinit -d ~/.zsh/zcompdump
setopt complete_in_word   # Allow completion from within a word/phrase
setopt completealiases    # Complete aliases
setopt always_to_end      # When completing from the middle of a word, move the cursor to the end of the word 
setopt auto_cd            # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt correct            # Spelling correction for commands

# Correction for commands
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? (Yes [y], No [n], Abort [a], Edit [e]): "

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

# list of completers to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

zstyle ':completion:*' menu select

# match uppercase from lowercasethen match both
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# formatting and messages
zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''


# ============ HISTORY ============ #

HISTFILE=~/.zsh/histfile
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


# ============ ENVIRONMENT ============ #

# Homebrew provided-program will be used instead of system-provided ones
homebrew_path=/usr/local/sbin
export PATH=$homebrew_path:$PATH

# Set default console Java to 1.8
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# My projects
export PROJECTS="$HOME/Documents/Projects"

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'


# ============ PROMPT ============ #

colors
setopt prompt_subst     # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt

PROMPT='%{$fg[red]%}%1~%{$reset_color%}$(git_super_status) %{$fg[white]%}❯%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}%T%{$reset_color%}'

# Git prompt
source "$PROJECTS/zsh-git-prompt/zshrc.sh"
export GIT_PROMPT_EXECUTABLE="haskell"


# ============ ALIASES ============ #

# Add file type indicator, and put sizes in human readable format
alias ls='ls -Fh'

# Add command Sublime Text command line tools
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# Scala REPL uses different colors when printing references to vals and types
alias scala='scala -Dscala.color'
