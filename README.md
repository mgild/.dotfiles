# .dotfiles

To install, run setup.sh

Prereqs: zsh, vim, wget, cmake, libpython2.7-dev, git, ctags, tmux

Reference this guide if you have trouble with powerline fonts:
http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin

Change your non-ASCII character font for your preferred terminal to one of the provided powerline fonts

For tmux powerline:
- In ~/.tmux.conf it seems OS dependant whether you can source from anything other than an absolute path. You may need to change the source line
- If Powerline is blank, try 'powerline-daemon --replace' while in tmux
