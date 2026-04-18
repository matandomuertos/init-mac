# sources:
# - https://macos-defaults.com/
# - Google

###############################################################################
# Install stuff                                                               #
###############################################################################
## Install brew ##
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew install --cask brave-browser
brew install --cask steam
brew install --cask visual-studio-code
brew install --cask discord
brew install --cask coconutbattery
brew install --cask proton-drive
brew install --cask protonvpn
brew install --cask spotify
brew install --cask docker
brew install --cask vlc
brew install protonpass/tap/pass-cli
brew install stats
brew install git
brew install wget
brew install unzip
brew install telnet
brew install node
brew install watch
brew install MonitorControl
brew install carlocab/personal/unrar
brew install telegraf
brew install mactop
brew install tenv
brew install helm
brew install flux
brew install kubectl
brew install kubectx
brew install krew
brew install hidetatz/tap/kubecolor
kubectl krew install get-all
kubectl krew install resource-capacity
kubectl krew install view-secret
kubectl krew install stern

#brew install --cask microsoft-outlook
#brew install --cask zoom
#brew install --cask firefox
#brew install --cask google-cloud-sdk
#brew install istioctl
#brew install cilium-cli
#brew install awscli
#brew install argocd
#brew install jq
#brew install wallpaper

# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


###############################################################################
# Add koko to hosts                                                           #
###############################################################################
cat <<EOF | sudo tee -a /etc/hosts > /dev/null
192.168.0.102 koko
192.168.0.104 koko-dev
192.168.0.105 koko-claw
192.168.0.100 koko-pve1
192.168.0.101 koko-pve2
192.168.0.103 pbs
192.168.0.108 k3d1
192.168.0.112 k3d1-dev
EOF


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
echo "Configuring Dock..."

# Reset Dock to default state (removes all pinned apps)
defaults write com.apple.dock persistent-apps -array

# Layout settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -int 51
defaults write com.apple.dock largesize -float 75
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "genie"

# Apply changes
killall Dock

## Energy ##
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

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
defaults write com.apple.finder "FXPreferredViewStyle" -string "icnv"
# Enable path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Disable title rollover delay
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
# Set sidebar icons size
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "2"
# Kill Finder
killall Finder

## Activity Monitor ##
defaults write com.apple.ActivityMonitor "UpdatePeriod" -int 1
defaults write com.apple.ActivityMonitor "SortColumn" -string "CPUUsage"
defaults write com.apple.ActivityMonitor "SortDirection" -int 0
defaults delete com.apple.ActivityMonitor "MainWindowWindowState"

## Time Machine ##
# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

## Terminal ##
# Add custom theme to terminal and set it as default
open ~/custom.terminal
defaults write com.apple.terminal "Default Window Settings" -string "custom"
defaults write com.apple.Terminal "Startup Window Settings" -string "custom"

## Photos ##
# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
killall ImageCaptureExtension

## System ##
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

###############################################################################
# Copy files                                                                  #
###############################################################################
cp gitconfig ~/.gitconfig && chmod 644 ~/.gitconfig
cp zshrc ~/.zshrc && chmod 644 ~/.zshrc
cp firewatch.jpg ghost-of-tsushima.jpg ~/Pictures/ && chmod 644 ~/Pictures/firewatch.jpg && chmod 644 ~/Pictures/ghost-of-tsushima.jpg
cp telegraf.conf /opt/homebrew/etc/telegraf.conf && chmod 644 /opt/homebrew/etc/telegraf.conf

###############################################################################
# Start telegraf                                                              #
###############################################################################
brew services start telegraf

###############################################################################
# Final message and restart                                                   #
###############################################################################
osascript -e 'display notification "Setup finished. Your mac will be restarted soon." with title "Mac Setup"'

echo "Done. Your Mac will be restarted in"
for i in {10..1}                                     
do                
  echo $i
  sleep 1
done
echo "Restarting..."
sudo reboot
