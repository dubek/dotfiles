#!/bin/bash

bindir=$(dirname $0)
cd $bindir
fulldir=$PWD

files="editrc gemrc gitconfig gitignore irbrc rvmrc tmux.conf vimrc"
for f in $files ; do
  ln -v -s $fulldir/$f ~/.$f
done

if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
  mkdir -p ~/.vim/bundle
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git
  vim +PluginInstall +qall
fi

cat <<'EOF'
TODO: Add this line to the end of ~/.bashrc:

    . $HOME/dotfiles/bash/config

TODO: Add this line to the end of ~/.profile:

    . $HOME/dotfiles/bash/profile.sh

EOF
