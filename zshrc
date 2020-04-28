ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

__zplug::io::file::generate

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Themes
zplug 'romkatv/powerlevel10k', as:'theme', depth:'1'

# Plugins
zplug "lib/history", from:'oh-my-zsh', depth:'1'
zplug "junegunn/fzf", use:"shell/*.zsh", depth:'1'
zplug "zsh-users/zsh-autosuggestions", depth:'1'
zplug 'zsh-users/zsh-syntax-highlighting', depth:'1', defer:'2'
zplug "b4b4r07/enhancd", use:'init.sh', depth:'1'

# Local config
zplug '$HOME/.dotfiles/zsh', from:'local', defer:'2'

if zplug check "b4b4r07/enhancd"; then
  ENHANCD_FILTER="fzf"
  ENHANCD_COMPLETION_BEHAVIOR='list'
fi

zplug check || zplug install

# History configuration
setopt hist_ignore_all_dups
setopt hist_ignore_space
unsetopt nomatch

zplug load

# Source other resource
# [ -f $HOME/.localrc ] && source $HOME/.localrc # Local configuration
# [ -f /usr/bin/pyenv ] && eval "$(pyenv init -)" # pyenv
# [ -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ] && eval "$(pyenv virtualenv-init -)" # pyenv-virtualenv
# [ -f $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm

# GNOME KEYRING DAEMON integration in shell
[ -n "$DESKTOP_SESSION" ] && export $(gnome-keyring-daemon --start)

# Avoid duplicated in PATH
export -U PATH
