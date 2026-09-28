*CHANGELOG*

## 1.1.0
### Added: jq, wev, pipx, gemget, rogallo, gtl
* all-packages.nix: jq, wev
* home-packages: pipx, gemget
* pipx: rogallo
* bin: gtl - Gemini Tinylog Reader (binary)
### Added: rofimoji Emoji Picker on "super+."
### Config: added swallowing; added application/pdf
* Added swallowing to alacritty in hyprland.lua
+ Added application/pdf -> zathura to home-applications.nix

## 1.0.0 - First Major release
### Config: added "xdg.desktopEntries.qutebrowser-xdg"
* Added Qutebrowser configuration for eg. xdg-open
### Config: added ".mailcap"; Added: zathura
* Added .mailcap configuration to home-applications
* Added zathura PDF viewer to home-packages.nix
### Changed: wofi, SyncNC; Added: elinks
* Made fonts of wofi and SyncNC a little bigger
* Added elinks terminal www browser to view HTML emails in NeoMutt
### Initial Commit
* Removed all secrets from Repo
* Added import of secrets (gpg, ssh, password-store) from (local) SSH server
* Other things...
* Made ready to publish on GitHub

## 0.3.0 - Third minor release
### Repo: added .luac.json to the repository root
* Added .luac.json for hyprland.lua to the repository root. So I have autocomplete, no "unknown variable" errors and so on.
### README.md: updated
### Config: Multiple changes
* Moved some programs from home-packages.nix to all-packages.nix and vice versa
* BUGFIX: Made the resize keys (SUPER+SHIFT+Arrowkey) function the right way. They didn't work as expected before.
* Made changes to the general color schemes for GTK and QT (Adwaita-Dark)
* Modularized flake further and separated the root user from flake.nix to ./modules/root-home.nix
* Did further cleanup
* Other things...
### Config: Removed vmVariant completely from vm.nix
* The vmVariant configuration was completely removed from the vm.nix config, because it was broken. Now only "build-vm-with-bootloader" should be used (although the creation takes much more time)
### Config: added some aliases to bashrc
### Added: "par" formatting tool for LazyVim
### Config: Changed to hyprpaper to show only one image
### Config: Changed Scratchpad resolution
* Changed Scratchpad Resolution to 60%/70%
### README.md: updated
### ChatGPT: adapted chatgpt-deutsch.sh to new modularized file layout
### Modularized all.nix
* Split original all.nix in all.nix and a few files under "./modules": all-audio.nix, all-fonts.nix, all-hyprland.nix, all-localization.nix, all-network.nix, all-nix.nix, all-packages.nix, all-user.nix, all-wayland.nix
### Modularized home.nix
* Split original home.nix in home.nix and a few files under "./modules": home-applications.nix, home-desktop.nix, home-gpg.nix, home-lazyvim.nix, home-packages.nix, home-private.nix, home-shell.nix
* Added new password hash for test VMs
### README.md: First introduction
### Config: disabled TouchPad, added brightness controls

## 0.2.0 - Second minor release: Switch to only hyprland
### Config: Added sound to VMs
* Added sound support to build-vm-with-bootloader VMs by adding the needed devices to vm.nix
### Added: wofi radio script
* Added programs: mpv, SwayNC, libnotify, Script: wofi/radio.sh
* Config: changed keybindings - SUPER+M -> radio selector; SUPER-CTRL-Q -> end hyprland session
### Config: Changed QT to adwaita-dark in home.nix
### BUGFIX: VMs didn't let the mouse move when grabbed
* VMs build with build-vm-with-bootloader didn't let the mouse move when grabbed. This was fixed with the use of sdl instead of gtk in the VM configuration
### Changed: wofi shows now a maximum of 25 lines and has a width of 30%
### Changed: Configuration name for real builds changed from "nixos-nfs" to "nixos"
### BUGFIX: otpmenu.sh didn't work
* The otpmenu.sh script (SUPER+O) didn't work, because the "OTP" extension wasn't installed. This is now fixed.
### BUGFIX: build-vm-with-bootloader didn't resize vda2; Added wofi config
* build-vm-with-bootloader is now the standard way to test config changes
* wofi style was added together with the scripts "passmenu.sh" and "otpmenu.sh"
### Config: changed "Print" key to "Super" (mod4); Added: neomutt; Other changes
* *Finnally* the "Print" key is usable as left "Super" (mod4) key
* neomutt: Installed and make configuration available
* bashrc: Added aliases for my different NeoMutt configs: dcm, uwm, fab
* Changed prompt outputs from scripts for ChatGPT
### Config: Changed scratchpad, fixed typo, added volume; BUGFIX: gpg
* Changed size of the scratchpad to 80%/60%
+ Fixed tyoo in home.nix
* Added volume keys and waybar display
* Programs that use gpg didn't start pinentry(-curses)
### Refactor: switch to hyperland
* Switched configuration completely to hyprland only
* Configured hyprland and waybar
* Added and removed some programs
* Multiple other configuration changes
* Removed QTile and X11 completely
* Added prompt output scripts for ChatGPT
* other things...

## 0.1.0 - First minor release
### Feature(screen): Same screen scaling on X11 and Wayland
* Added ".Xresources" option "Xft.dpi: 96" and set alacritty font size to 11.0 to have same screen resolution on X11 and Wayland
### BUGFIX: QTile configuration goes back to default; Changed DF widget
* There was an error in the qtile config.py file: Missing "import" in "from" line. This caused QTile to fallback to the default config.
* The original DF widget showed a lot of numbers after the decimal point. This is now reduced to one digit.
### Feature(screenshots): Enabled screenshots
* This commit enables screenshots with "super+s" in X11 and Wayland
### Configuration: file removed
* I removed the no longer needed file 'vm-configuration.nix'
### Feature(sound): Activate Sound in X11 and Wayland
* This activates general sound for both, X11 and Wayland
### Feature(~/bin): Install ~/bin directory
* This installs a "$HOME/bin" directory, which is handled by the NixOS config, so to place programs in ~/bin, you have to add them to the "config/bin" directory in the NixOS configuration.

## 0.0.4
### SYSTEM UPGRADE: NixOS 26.05
* Upgraded the whole configuration to NixOS 26.05
### Changed: moved and added programs
* moved eza from home.nix to all, added htop to all.nix
### BUGFIX: VMs don't set hostname correcty
* A bug caused the VMs not to change the hostname when updating it in vm.nix, because the option was at the wrong position. This is now fixed.
### Refactor vm.nix
* Refactored vm.nix, so it can really do a rebuild

## 0.0.3
### Added: todo-txt-cli, freetube; changed: bashrc
* Added the two packages todo-txt-cli and freetube
* Added todo support to bashrc, with alias and initial output on terminal start
### BUGFIX(bashrc): Added support for HISTFILE
* The config now creates correct history files for mcfly for example.
### BUGFIX: VM tries to install bootloader on switch
* If running "sudo nixos-rebuild switch --flake .#vm", the system tries to install a bootloader and fails. This *should* fix this, and run the VM completely without a bootloader.
### First Refactor: Cleanly separated real and VM config
* Separated real builds for host system and VM build process
+ Files: flake.nix, all.nix, real.nix, vm.nix

## 0.0.2
### BUGFIX: .ssh, .password-store and secret.asc had insecure permissions.
* The directories ".ssh" and ".password-store" and the file "secret.asc" are now *copied* instead of symlinked to fix insecure permissions.
### Feat(Test-VM): Added flake to create a test VM of the whole system
* I created a new flake (vm-configuration.nix), which allows me to build a full virtual system from my NixOS configuration for testing

## 0.0.1
### BUGFIX: Git couldn't find /usr/bin/nvim. Now it uses "nvim" from $PATH
* Git couldn't find /usr/bin/nvim in NixOS (correct), so I added the "core.editor=vim" option to the Git config
### BUGFIX: Qutebrowser Config dir was not writeable
* The Qutebrowser Config dir was not writeable and qutebrowser didn't start anymore. Now only the needed files are copied into the nixos-store, so the file remains writeable.
* deleted a few unneccessary/wrong lines and fixed a typo
* Added "librewolf" to the home.nix programs
### BUGFIX: Path in Activation Script fixed
* The Path in the activation script to import aecret.asc gpg keys was wrong
* moved "./config/gnupg/secret.asc"" directly to ".gnupg" with `home.file`
* Added the "bat" pager to the global packages.
### Initial Commit
* Networking, Locale, Keymap
* DisplayManager "ly" (minimal)
* Initial Main Setup (flake.nix)
* GnuPG Setup (home.nix)
* Initial Main Setup (root, daniel) (flake.nix)

* Initial Home Setup (daniel) (home.nix):
* * Init Setup "bash"
* * Init Setup "mcfly"
* * Initial Program Configuration (git, pass, ssh, alacritty, eza, qutebrowser, starship, LazyVim)

* Initial QTile Config from Tony Banters
