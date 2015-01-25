#!/usr/bin/env sh

LN_CMD="ln -T -s"
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
