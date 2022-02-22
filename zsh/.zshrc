modules_path="${HOME}/.config/zsh/modules"
plugins_path="/usr/share/zsh/plugins"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


# Prompt
source $modules_path/prompt.zsh


# Completition
source $modules_path/completion.zsh


# VI mode
source $modules_path/vi-mode.zsh


# Syntax highlighting
source $plugins_path/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
