# init-mac

Personal macOS initialization and configuration scripts for Nahuel's development environment

## Overview

This repository contains configuration files and a setup script to quickly provision a new macOS machine with development tools, applications, and personalized settings.

## Repository Structure

```
init-mac/
├── init.sh                # Main setup script
├── gitconfig              # Git configuration
├── zshrc                  # Zsh shell configuration
├── telegraf.conf          # Telegraf metrics configuration
├── custom.terminal        # Terminal theme profile (dark background, 90x30)
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

**Applications (Cask):**
- Brave Browser
- Steam
- Visual Studio Code
- Discord
- CoconutBattery
- Proton Drive
- Proton VPN
- Spotify
- Docker Desktop
- VLC
- Proton Pass CLI

**Command Line Tools:**
- Git
- wget, unzip, telnet
- Node.js
- watch
- MonitorControl (for external monitor brightness)
- unrar (carlocab/personal)
- stats (system monitoring)
- telegraf (metrics collection)
- mactop (Apple Silicon monitoring)
- tenv (Tecla rsync)
- Helm, kubectl, kubectx, krew
- kubecolor (colored kubectl output)
- flux (GitOps tool)

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
- Imports `custom.terminal` theme (dark background, MenloRegular font, 90x30 window)
- Sets as default profile

**Activity Monitor:**
- Update period: 1 second
- Sorted by CPU usage
- Ascending order

**Energy/Security:**
- Password required immediately after sleep/screensaver
- Time Machine: Disabled prompt for new disks
- Auto-quit printer app after jobs complete
- Disable Photos auto-open on device plug-in

**Network:**
- Adds custom hosts for "koko" network (192.168.0.100-112)

### 3. File Setup

Copies configuration files to your home directory:
- `~/.gitconfig` - Git aliases and SSH signing configuration
- `~/.zshrc` - Zsh configuration with Oh My Zsh, kubectl aliases, and plugins
- `~/Pictures/firewatch.jpg` - Wallpaper
- `~/Pictures/ghost-of-tsushima.jpg` - Wallpaper
- `/opt/homebrew/etc/telegraf.conf` - Telegraf Prometheus metrics configuration
- Starts telegraf service via brew services

### 4. Automatic Restart

The script displays a 10-second countdown and automatically restarts the Mac to apply all settings.

## Configuration Files

### gitconfig

- **User:** Nahuel (<matandomuertos@users.noreply.github.com>)
- **Signing:** SSH GPG signing enabled (`format = ssh`)
- **Auto-setup:** Remote tracking enabled
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
- Python auto virtualenv: enabled (`PYTHON_AUTO_VRUN=true`)

**Kube-ps1 Plugin:**
- Symbol disabled (`KUBE_PS1_SYMBOL_ENABLE=false`)
- Hidden if no context (`KUBE_PS1_HIDE_IF_NOCONTEXT=true`)
- Displayed in right prompt

**History:**
- 10 million lines stored (`HISTSIZE=10000000`, `SAVEHIST=10000000`)
- Saved to `~/.zsh_history`

**Disabled Features:**
- Auto menu/tab completion (`noautomenu`, `nomenucomplete`)
- Auto update (`DISABLE_AUTO_UPDATE=true`) for faster init

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
- Krew binaries (`${KREW_ROOT:-$HOME/.krew}/bin`)
- Local user binaries (`$HOME/.local/bin`)
- Homebrew binaries (`/opt/homebrew/bin`)

### telegraf.conf

Telegraf configuration for Prometheus metrics:
- **Listen address:** `:9100`
- **Allowed IPs:** `192.168.0.102/32` and `127.0.0.0/32`
- **Interval:** 10 seconds
- **Metrics collected:**
  - CPU (per-cpu and total)
  - Memory
  - Swap
  - Network
  - Disk (ignores macOS virtual drives)
  - System
  - Temperature
  - **mactop metrics** (Apple Silicon monitoring) - 5s interval
    - CPU/GPU usage and temperatures
    - Power consumption
    - Fan RPM

### custom.terminal

Terminal profile with:
- Dark background
- Menlo Regular font with antialiasing
- 90 columns x 30 rows
- Cursor blink disabled
- ANSI color enabled

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

The following are in `init.sh` but commented out (uncomment to install):

**Applications:**
```bash
# brew install --cask microsoft-outlook
# brew install --cask zoom
# brew install --cask firefox
# brew install --cask google-cloud-sdk
```

**CLI Tools:**
```bash
# brew install istioctl
# brew install cilium-cli
# brew install awscli
# brew install argocd
# brew install jq
# brew install wallpaper
```

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
- kube-ps1 plugin for prompt (right-aligned, hidden when no context)
- Aliases for common kubectl operations
- Shortcuts for k3d-dev and k3d-prod contexts

## Monitoring Stack

- **telegraf:** Collects system and Apple Silicon metrics, exposes on port 9100
- **mactop:** Apple Silicon monitoring tool (integrated into telegraf)
- **stats:** System monitoring CLI tool

## License

This repository is personal configuration and is provided as-is. Feel free to use it as a reference for your own setup.

## Contributing

This is a personal configuration repository. However, if you find something useful or have suggestions, feel free to fork and adapt for your own needs.
