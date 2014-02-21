#!/bin/bash

# Requirements: zsh, curl, git.  Just die if they don't exist.
cmd=zsh
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd could not be found."
  echo "On ubuntu, try \"sudo apt-get install zsh\""
  echo "Exiting"
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
cmd=brew
if ! [ $(type -P "$cmd") ]; then
  while true; do
    read -p "Do you wish to install homebrew? " yn
    case $yn in
      [Yy]* ) 
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        echo "Done installing $cmd"
        break;;
      [Nn]* ) echo "Skipping homebrew"; break;;
      * ) echo "Please answer yes or no. Received [$yn]";;
    esac
  done
fi


## Oh-My-ZSH:
# Requires curl,sh,git,chsh
while true; do
  read -p "Do you wish to install oh-my-zsh? " yn
  case $yn in
    [Yy]* ) 
      curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
      echo "Done installing oh-my-zsh."
      echo ""
      echo ""
      echo ""
      echo ""
      echo "If the output above has a error like this:"
      echo "   Password: chsh: PAM authentication failed"
      echo "You can edit your ~/.bash_login and add this line:"
      echo "   exec /bin/zsh --login"
      echo "Press any key to continue:"
      read garbage
      break;;
    [Nn]* ) echo "Skipping oh-my-zsh"; break;;
    * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done

## Install Pip
# Requires python,sudo?
cmd=pip
if ! [ $(type -P "$cmd") ]; then
  while true; do
    read -p "$cmd not found. Would you like to install it? " yn
    case $yn in
      [Yy]* ) 
        echo "Installing $cmd."
        curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py > ~/get-pip.py
        sudo python get-pip.py
        rm ~/get-pip.py
        echo "Done installing $cmd"
        break;;
      [Nn]* ) echo "Skipping installing $cmd"; break;;
      * ) echo "Please answer yes or no. Received [$yn]";;
    esac
  done
else
  echo "$cmd found. Moving on"
fi

## Install Flake8:
# Requires sudo,pip
cmd=flake8
if ! [ $(type -P "$cmd") ]; then
  while true; do
    read -p "$cmd not found. Would you like to install it? " yn
    case $yn in
      [Yy]* ) 
        echo "Installing $cmd."
        sudo pip install flake8
        echo "Done installing $cmd"
        break;;
      [Nn]* ) echo "Skipping installing $cmd"; break;;
      * ) echo "Please answer yes or no. Received [$yn]";;
    esac
  done
else
  echo "$cmd found. Moving on"
fi

## Install VirtualEnvWrapper
# Requires sudo,pip
cmd=mkvirtualenv
if ! [ $(type -P "$cmd") ]; then
  while true; do
    read -p "$cmd not found. Would you like to install it? " yn
    case $yn in
      [Yy]* ) 
        echo "Installing $cmd."
        sudo pip install virtualenvwrapper
        echo "Done installing $cmd"
        echo "Please add a line to your .zshrc if you are maintaining that yourself:"
        echo "If using the supplied .zshrc, this may be already taken care of for you."
        echo "  source `which virtualenvwrapper.sh`"
        break;;
      [Nn]* ) echo "Skipping installing $cmd"; break;;
      * ) echo "Please answer yes or no. Received [$yn]";;
    esac
  done
else
  echo "$cmd found. Moving on"
fi

## zsh-syntax-highlighting
# Requires oh-my-zsh,git
while true; do
  read -p "Would you like to install zsh-syntax-highlighting? " yn
  case $yn in
    [Yy]* ) 
      echo "Installing zsh-syntax-highlighting."
      cd ~/.oh-my-zsh/plugins/
      git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
      echo "Done with zsh-syntax-highlighting"
      break;;
    [Nn]* ) echo "Skipping installing zsh-syntax-highlighting"; break;;
    * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done

## setup your ~/.zshrc
# Requires curl
while true; do
  read -p "Do you wish to overwrite your .zshrc with the one downloaded from zsh.sh/zshrc.txt? " yn
  case $yn in
    [Yy]* ) 
      echo "Overwriting. Your current .zshrc will be backed up to ~/.zshrc.bak "; 
      cp ~/.zshrc ~/.zshrc.bak; 
      curl zsh.sh/zshrc.txt > ~/.zshrc; 
      source ~/.zshrc;
      break;;
    [Nn]* ) echo "You chose No! Keeping existing .zshrc."; break;;
     * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done


## Vundle
# Requires git
while true; do
  read -p "Would you like to clone vundle? " yn
  case $yn in
    [Yy]* ) 
      echo "Cloning vundle."; 
      git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
      echo "Done cloning vundle"
      break;;
    [Nn]* ) echo "You chose No! Not cloning vundle."; break;;
     * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done


## setup your ~/.vimrc
# Requires curl
while true; do
  read -p "Do you wish to overwrite your .vimrc with the one downloaded from zsh.sh/vimrc.txt? " yn
  case $yn in
    [Yy]* ) echo "Overwriting. Your current .vimrc will be backed up to ~/.vimrc.bak "; 
      cp ~/.vimrc ~/.vimrc.bak; 
      curl zsh.sh/vimrc.txt > ~/.vimrc; 
      break;;
    [Nn]* ) echo "You chose No! Keeping existing .vimrc."; break;;
     * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done


## Run BundleInstall (Ignore pathogen#infect errors this time)
while true; do
  read -p "Do you wish to run \"vim +BundleInstall +qall\" to install your vim bundles? " yn
  case $yn in
    [Yy]* ) echo "Running bundleinstall... "; 
      echo "Ignore any pathogen#infect errors this time."
      vim +BundleInstall +qall
      echo "Done running bundleinstall."
      break;;
    [Nn]* ) echo "You chose No! Not running bundleinstall."; break;;
     * ) echo "Please answer yes or no. Received [$yn]";;
  esac
done

## Install git flow
# Requires git,brew
#brew install git-flow
cmd=git-flow
if ! [ $(type -P "$cmd") ]; then
  echo "$cmd not found." 
  while true; do
    read -p "Do you wish to run \"brew install git-flow\" ?" yn
    case $yn in
      [Yy]* ) echo "Installing git-flow..."; 
        brew install git-flow
        echo "Done installing git-flow."
        break;;
      [Nn]* ) echo "You chose No! Not installing git-flow."; break;;
       * ) echo "Please answer yes or no. Received [$yn]";;
    esac
  done
else
  echo "$cmd found. Moving on"
fi

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
blahblahblah

