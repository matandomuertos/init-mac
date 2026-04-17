# init-mac

> Personal macOS initialization and configuration scripts for Nahuel's development environment

## Overview

This repository contains configuration files and a setup script to quickly provision a new macOS machine with development tools, applications, and personalized settings.

## Repository Structure

```
init-mac/
├── init.sh                # Main setup script
├── gitconfig              # Git configuration
├── zshrc                  # Zsh shell configuration
├── telegraf.conf          # Telegraf metrics configuration
├── custom.terminal        # Terminal theme profile
├── firewatch.jpg          # Wallpaper image
└── ghost-of-tsushima.jpg  # Wallpaper image
```

## Quick Start

```bash
# Clone the repository
 git clone https://github.com/matandomuertos/init-mac.git
 cd init-mac

# Review the script before running
 ./init.sh
```

> **Warning:** The script will automatically restart your Mac at the end. Save all work before running.

## What It Does

### 1. Software Installation (via Homebrew)

**Applications:**
- Brave Browser
- Steam
- Visual Studio Code
- Discord
- CoconutBattery
- Proton Drive & VPN
- Spotify
- Docker Desktop
- VLC
- Proton Pass CLI

**Command Line Tools:**
- Git
- wget, unzip, telnet
- Node.js
- watch
- MonitorControl
- unrar
- tenv (Tecla rsync)
- Helm, kubectl, kubectx, krew
- kubecolor
- flux

**Krew Plugins:**
- get-all
- resource-capacity
- view-secret
- stern

**Shell:**
- Oh My Zsh

### 2. System Configuration

**Dock:**
- Auto-hide with fast animation (0.3s delay, 0s hide delay)
- Magnification enabled
- Tile size: 51px, magnified size: 75px
- Minimize to application
- Show process indicators
- Hide recent applications
- Genie minimize effect
- All pinned apps cleared (fresh start)

**Finder:**
- Home directory as default
- Folders sorted first
- Search current folder by default
- No .DS_Store files on network/USB volumes
- Icon view by default
- Path bar enabled
- Save to disk (not iCloud) by default
- Small sidebar icons

**Terminal:**
- Imports `custom.terminal` theme
- Sets as default profile

**Energy/Security:**
- Password required immediately after sleep/screensaver

**Network:**
- Adds custom hosts for "koko" network (192.168.0.100-112)

### 3. File Setup

Copies configuration files to your home directory:
- `~/.gitconfig` - Git aliases and signing configuration
- `~/.zshrc` - Zsh configuration with Oh My Zsh, kubectl aliases, and plugins
- `~/Pictures/firewatch.jpg` - Wallpaper
- `~/Pictures/ghost-of-tsushima.jpg` - Wallpaper
- Telegraf config (manual setup required)

## Configuration Files

### gitconfig

- **User:** Nahuel (<matandomuertos@users.noreply.github.com>)
- **Signing:** SSH GPG signing enabled
- **Aliases:**
  - `ac` - Add all and commit with message
  - `c` - Commit all with message
  - `up` - Checkout master and pull
  - `cb` - Checkout new branch
  - `t` - Checkout existing branch
- **Editor:** vim

### zshrc

**Oh My Zsh Configuration:**
- Theme: `simple`
- Plugins: `python`, `kubectl`, `kube-ps1`
- Python auto virtualenv: enabled

**History:**
- 10 million lines stored
- Saved to `~/.zsh_history`

**Disable Features:**
- Auto menu/tab completion
- Auto update (for faster init)

**Aliases:**
- `kubectl` → `kubecolor` (colored output)
- `k` → `kubectl`
- `kube` → `kubectl`
- `kc` → `kubectl config get-contexts`
- `kns` → `kubens`
- `kx` → `kubectx`
- `dev` → `kubectx k3d-dev`
- `prod` → `kubectx k3d-prod`
- `ssh` → `ssh -o StrictHostKeyChecking=no`

**Path Additions:**
- Krew binaries
- Local user binaries
- Homebrew binaries

### telegraf.conf

Telegraf configuration for Prometheus metrics:
- Listens on `:9100`
- Allows connections from `192.168.0.102/32` and `127.0.0.0/32`
- Collects metrics: CPU, memory, swap, network, disk, temperature, system
- 10-second interval

## Customization

### Before Running

1. **Edit `init.sh`:**
   - Modify the hosts entries for your network
   - Add/remove applications as needed
   - Adjust macOS settings to your preference

2. **Edit `gitconfig`:**
   - Update name and email
   - Change SSH signing key path if different

3. **Edit `zshrc`:**
   - Update plugins list
   - Add your own aliases
   - Modify kubernetes context shortcuts

### After Running

- Wallpapers: Set manually in System Preferences > Desktop & Screen Saver
- Terminal: The custom theme will be available in Terminal preferences

## Available but Commented Out

The following are in `init.sh` but commented out:

```bash
# brew install --cask microsoft-outlook
# brew install --cask zoom
# brew install --cask firefox
# brew install --cask google-cloud-sdk
# brew install awscli
# brew install argocd
# brew install istioctl
# brew install cilium-cli
# brew install jq
# brew install wallpaper
```

Uncomment these lines if you need them.

## Requirements

- macOS (tested on recent versions)
- Internet connection (for Homebrew installations)
- Administrator privileges (for system configuration)

## Network Hosts

The script adds these hosts to `/etc/hosts`:

| IP            | Hostname  |
| ------------- | --------- |
| 192.168.0.100 | koko-pve1 |
| 192.168.0.101 | koko-pve2 |
| 192.168.0.102 | koko      |
| 192.168.0.103 | pbs       |
| 192.168.0.104 | koko-dev  |
| 192.168.0.105 | koko-claw |
| 192.168.0.108 | k3d1      |
| 192.168.0.112 | k3d1-dev  |

Update these in `init.sh` if your network uses different IPs.

## Kubernetes Configuration

The setup includes:
- kubectl, kubectx, kubens, krew
- kubecolor for colored output
- Krew plugins: get-all, resource-capacity, view-secret, stern
- Oh My Zsh kubectl plugin
- kube-ps1 plugin for prompt
- Aliases for common kubectl operations
- Shortcuts for k3d-dev and k3d-prod contexts

## License

This repository is personal configuration and is provided as-is. Feel free to use it as a reference for your own setup.

## Contributing

This is a personal configuration repository. However, if you find something useful or have suggestions, feel free to fork and adapt for your own needs.
