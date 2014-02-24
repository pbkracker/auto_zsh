auto_zsh
========

A few scripts to auto-install my favorite CLI development tools like zsh, oh-my-zsh, brew, pip, flake8, virtualenvwrapper, vundle, a number of preferred vundles, and git-flow.

zsh.sh is an interactive installer

    sh -c "$(curl zsh.sh/zsh.sh)"

vimrc.txt and zshrc.txt are optionally downloaded to replace ~/.vimrc and ~/.zshrc

TODO:

1. Only present brew as an option if we're on a mac.
2. Attempt to verify installation success.
3. Allow customization of zshrc and vimrc.
4. Setup SSL on zsh.sh
5. Refactor.
 1. Reuse code in functions.
 2. Provide a list of tools in a data structure.
 3. Keep track of requirements and installation methods.

ASCII Art is all Copyright © ascii-art.de:
http://www.ascii-art.de/info/copyright/
