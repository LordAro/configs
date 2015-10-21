#!/usr/bin/env sh

cmd_exists () {
	return command -v $1 >/dev/null 2>&1
}

PLATFORM=`uname`

LN_CMD="ln -s"
if [ "$PLATFORM" = "FreeBSD" ]; then
	LN_CMD="$LN_CMD -h"
else
	LN_CMD="$LN_CMD -T"
fi
if [ "$1" = "-f" ]; then
    echo "Forcing..."
    LN_CMD="$LN_CMD -f"
fi

dir=`pwd`

## Actual dot files ##

DOTFILES="gitconfig vimrc vim bashrc bash_profile tmux.conf"

for file in $DOTFILES; do
    $LN_CMD $dir/config/$file $HOME/.$file
done

## Other files ##

mkdir -p $HOME/.ssh
if [ -z "`grep york /etc/resolv.conf`" ]; then
    $LN_CMD $dir/config/ssh-config $HOME/.ssh/config
else
    $LN_CMD $dir/config/ssh-config-yk $HOME/.ssh/config
fi

if cmd_exists xrdb; then
    $LN_CMD $dir/config/Xresources $HOME/.Xresources
	xrdb -merge $HOME/.Xresources
fi
