grep -vq "/$USER/" <<< "$XDG_CACHE_HOME"  && export XDG_CACHE_HOME=$HOME/.cache
grep -vq "/$USER/" <<< "$XDG_CONFIG_HOME" && export XDG_CONFIG_HOME=$HOME/.config
grep -vq "/$USER/" <<< "$XDG_DATA_HOME"   && export XDG_DATA_HOME=$HOME/.local/share

ZDOTDIR=$XDG_CONFIG_HOME/zsh
[ -r ~/.zshenv_local ] && . ~/.zshenv_local

[ -r /etc/profile.d/modules.sh ] && type module > /dev/null || {
  . /etc/profile.d/modules.sh
  module list > /dev/null 2>&1
}
