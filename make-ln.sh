#!/usr/bin/env sh

HOMEFILES="gitconfig vimrc"

LN_CMD="ln -s"
if [ "$1" = "-f" ]; then
    echo "Forcing..."
    LN_CMD="$LN_CMD -f"
fi

dir=`pwd`

for file in $HOMEFILES; do
    $LN_CMD $dir/config/$file $HOME/.$file
done

mkdir -p $HOME/.ssh
$LN_CMD $dir/config/ssh-config $HOME/.ssh/config
