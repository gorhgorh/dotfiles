# Enable Powerlevel10k instant prompt. Should stay at the very top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh
# load config files from ~
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Initialize zplug early
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Load Powerlevel10k theme first
zplug romkatv/powerlevel10k, as:theme, depth:1

# Other zplug plugins
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "srijanshetty/node.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug lukechilds/zsh-better-npm-completion
zplug "Tarrasch/zsh-autoenv"
zplug "hcgraf/zsh-mercurial"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load zplug plugins
zplug load

# power level 9k
# autoload -U promptinit; promptinit
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# POWERLEVEL9K_MODE='nerdfont-complete'
# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# history
## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi
skip_global_compinit=1

#MENU_COMPLETE="true"
#CASE_SENSITIVE="false"
# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# dirs
setopt auto_cd
setopt auto_pushd
unsetopt pushd_ignore_dups
setopt pushdminus

# superglobs
setopt extendedglob
unsetopt caseglob

# better autocomplete
fpath=(/usr/local/share/zsh-completions $fpath)
setopt auto_menu
setopt always_to_end
setopt complete_in_word
unsetopt flow_control
unsetopt menu_complete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# load syntax highlighting
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# OPAM configuration
# . /Users/gorhgorh/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


# Load completion system
autoload -Uz compinit
compinit

eval $(thefuck --alias)

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#zsh-history-substring-search key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# java21
export JAVA_HOME="/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# z.sh
. /opt/homebrew/etc/profile.d/z.sh

# Source p10k configuration at the end
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# pnpm
export PNPM_HOME="/Users/gorhgorh/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
