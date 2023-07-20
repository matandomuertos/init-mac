# Install stuff
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew install --cask google-chrome
brew install --cask steam
brew install --cask visual-studio-code
brew install --cask discord
brew install --cask coconutbattery
brew install --cask google-drive
brew install --cask topnotch
brew install --cask rectangle
brew install --cask spotify
brew install --cask tunnelbear
brew install --cask docker
brew install git
brew install wget
brew install unzip
brew install telnet
brew install node
sudo gem install iStats

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add koko to hosts
sudo echo "192.168.31.167 koko" >> /etc/hosts

## Configure MacOs ##
# Remove all the icons from the dock
defaults write com.apple.dock persistent-apps -array && killall Dock
# Ajust mouse sensibility
defaults write .GlobalPreferences com.apple.mouse.scaling 0.6875

