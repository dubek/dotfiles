#
# This is included from ~/.profile
#

export PATH=$PATH:/usr/local/go/bin

case "$TERM" in
screen|tmux)
    ;;
*)
    printf '\n\033[01;32m'
    echo "################################"
    echo "#                              #"
    echo "# Consider running tmux-resume #"
    echo "#                              #"
    echo "################################"
    printf '\033[00m\n'
    ;;
esac
