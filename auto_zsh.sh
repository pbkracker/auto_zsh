#!/bin/bash

# Requirements: zsh, curl, git.  Just die if they don't exist.
cmd=zsh
if ! [ $(type -P "$cmd") ]; then
  echo ""
  echo ""
  echo ""
  echo ""
  echo ""
  echo "$cmd could not be found. Exiting."
  echo "On ubuntu, try \"sudo apt-get install zsh\""
  echo "On Redhat/CentOS, try \"sudo yum install zsh\""
  exit
fi

cmd=curl
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd could not be found. Exiting."
  exit
fi

cmd=git
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd could not be found. Exiting."
  exit
fi

echo "Requirements Met. Moving on."

## Install Brew:
# Requires ruby,curl
# Needed for git flow
#ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

## Oh-My-ZSH:
# Requires curl,sh,git,chsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo "OH-MY-ZSH Complete."

echo "Forcing shell change to zsh with chsh"
sudo chsh -s `which zsh` $USER
echo "Done forcing shell change to zsh."

## Install Pip
# Requires python,sudo?
cmd=pip
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd not found. Installing."
  curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py > ~/get-pip.py
  sudo python get-pip.py
  rm ~/get-pip.py
else
  echo "$cmd found. Moving on"
fi

## Install Flake8:
# Requires sudo,pip
cmd=flake8
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd not found. Installing."
  sudo pip install flake8
else
  echo "$cmd found. Moving on"
fi

## Install VirtualEnvWrapper
# Requires sudo,pip
cmd=mkvirtualenv
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd not found. Installing virtualenvwrapper."
  sudo pip install virtualenvwrapper
else
  echo "$cmd found. Moving on."
fi

## zsh-syntax-highlighting
# Requires oh-my-zsh,git
echo "Getting zsh-syntax-highlighting"
cd ~/.oh-my-zsh/plugins/
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
echo "Done with zsh-syntax-highlighting"

## setup your ~/.zshrc
# Requires curl
curl zsh.sh/zshrc.txt > ~/zshrc.txt;

## Vundle
# Requires git
echo "Cloning vundle"
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Done cloning vundle"

## setup your ~/.vimrc
# Requires curl
curl zsh.sh/vimrc.txt > ~/vimrc.txt; 

## Run BundleInstall (Ignore pathogen#infect errors this time)
#vim +BundleInstall +qall


## Install git flow
# Requires git,brew
#brew install git-flow



echo ""
echo ""
echo ""
echo ""

cat <<"blahblahblah"
                                                       Zsh                                                                                          
                                                  Zsh 
                                  .,.,        zsh 
                                 ((((())    zsh 
                               ((('_  _`) '
    _______________________    ((G   \ |)      ___________________
                              (((`   " ,
                               .((\.:~:          .--------------.
     The environment           __.| `"'.__      | \              |
                            .''   `---'   `.    |  .             :
     has been successfully /                `   |   `-.__________)
                          |             ~       |  :             :
     installed.           |                     |  :  |
                          |    _                |     |   [ ##   :
     woot woot!!!         \    `--.        ____|  ,   oo_______.'
                            `_   ( \) _____/     `--___
                            | `--)  ) `-.   `---   ( - .:. -
                            |   '///`  | `-.
                            |     | |  |    `-.
                            |     | |  |       `-.
                            |     | |\ |
                            |     | | \|
                             `-.  | |  |
                                `-| '

                                
The default zshrc has been downloaded to ~/zshrc.txt
Please run:
  mv ~/zshrc.txt ~/.zshrc

The default vimrc has been downloaded to ~/vimrc.txt
Please run:
  mv ~/vimrc.txt ~/.vimrc
  vim +BundleInstall +qall
    (Ignore the pathogen#infect errors on the first invocation of vim)

If the output above has a error like this:
   Password: chsh: PAM authentication failed
You can run this command to append a line to your .bash_login.  This will
take effect the next time you login.
   echo "exec /bin/zsh --login" >> ~/.bash_login
 Or, do this:
   sudo chsh -s /bin/zsh <your_username>
blahblahblah

