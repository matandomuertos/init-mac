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

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Configure MacOs ##
# Remove all the icons from the dock
defaults write com.apple.dock persistent-apps -array && killall Dock
# Ajust mouse sensibility
defaults write .GlobalPreferences com.apple.mouse.scaling 0.6875
# Disable delay autohide dock
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Enable Dock magnification
defaults write com.apple.dock magnification -bool true
# Set the icon size of Dock items to 51 pixels
defaults write com.apple.dock tilesize -int 51
# Set manification size
defaults write com.apple.dock largesize -float 75
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true
# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
# Sleep the display after 10 minutes when charger is connected
sudo pmset -c displaysleep 10
# Sleep the display after 2 minutes when working on battery
sudo pmset -b displaysleep 2

