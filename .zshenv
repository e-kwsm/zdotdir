[ -n "$XDG_CACHE_HOME"  ] || export XDG_CACHE_HOME="$HOME/.cache"
[ -n "$XDG_CONFIG_HOME" ] || export XDG_CONFIG_HOME="$HOME/.config"
[ -n "$XDG_DATA_HOME"   ] || export XDG_DATA_HOME="$HOME/.local/share"
[ -n "$XDG_STATE_HOME"  ] || export XDG_STATE_HOME="$HOME/.local/state"

ZDOTDIR=$XDG_CONFIG_HOME/zsh

if ! type module > /dev/null 2>&1; then
  if [ -r /etc/profile.d/modules.sh ]; then
    . /etc/profile.d/modules.sh
  elif [ -r /etc/profile.d/lmod.sh ]; then
    . /etc/profile.d/lmod.sh
  fi
fi

if [ -r ~/.zshenv_local ]; then
  . ~/.zshenv_local
fi
