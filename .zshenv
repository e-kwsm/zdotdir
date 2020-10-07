[ -n "$XDG_CACHE_HOME"  ] || export XDG_CACHE_HOME="$HOME/.cache"
[ -n "$XDG_CONFIG_HOME" ] || export XDG_CONFIG_HOME="$HOME/.config"
[ -n "$XDG_DATA_HOME"   ] || export XDG_DATA_HOME="$HOME/.local/share"

ZDOTDIR=$XDG_CONFIG_HOME/zsh
if [ -r ~/.zshenv_local ]; then
  . ~/.zshenv_local
fi

if [ -r /etc/profile.d/modules.sh ] && ! type module > /dev/null 2>&1; then
  . /etc/profile.d/modules.sh
  module refresh
fi
