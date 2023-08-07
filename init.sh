# sources:
# - https://macos-defaults.com/
# - Google

###############################################################################
# Install stuff                                                               #
###############################################################################
## Install brew ##
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
## brew installs
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
brew install wallpaper
brew install node
# Install iStats
sudo gem install iStats
# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


###############################################################################
# Add koko to hosts                                                           #
###############################################################################
sudo echo "192.168.31.167 koko" >> /etc/hosts


###############################################################################
# Prepare to config                                                           #
###############################################################################
# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'
# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# Config MacOS                                                                #
###############################################################################
## Dock ##
# Remove all the icons from the dock
defaults write com.apple.dock persistent-apps -array
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Reduce delay autohide dock
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
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
# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
# Kill Dock to apply changes
killall Dock
# TODO: https://stackoverflow.com/questions/23069864/adding-applications-to-dock-through-terminal - Need all the apps set to create the query

## Mouse and trackpad ##
# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Ajust mouse sensibility
defaults write .GlobalPreferences com.apple.mouse.scaling 0.6875

## Wallpaper ##
# Download wallpapers
wget https://i.imgur.com/7dLElgB.jpg -O ~/Pictures/aperture.jpg
wget https://i.imgur.com/wTi5pSF.jpg -O ~/Pictures/nerve.jpg
wget https://i.imgur.com/5eEWJhW.png -O ~/Pictures/glados.png
wallpaper set ~/Pictures/aperture.jpg

## Energy ##
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Sleep the display after 10 minutes when charger is connected
sudo pmset -c displaysleep 10
# Sleep the display after 2 minutes when working on battery
sudo pmset -b displaysleep 2
# Enable low power mode on battery
sudo pmset -b lowpowermode 1

## System ##
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

## Finder ##
# Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Use icon view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"


###############################################################################
# Final message and restart                                                   #
###############################################################################
echo "Done. Your Mac will be restarted in"
for i in {10..1}                                     
do                
  echo $i
  sleep 1
done
echo "Restarting..."
sudo reboot
