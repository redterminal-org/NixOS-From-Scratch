*CHANGELOG*

## 2.2.0
### Config: add Ansible and Python 3
* Add Ansible and Python 3 to the Home Manager packages.
### CHANGELOG.md: updated

## 2.1.0
### Config: install custom CA certificate for qutebrowser
* Add the LinuxCult.net CA certificate to the qutebrowser configuration.
* Install or update the CA in qutebrowser's NSS certificate database during Home Manager activation.
* Compare the SHA-256 fingerprint before replacing an existing certificate.
### Config: apply Tokyo Night colors to qutebrowser
* Replace the existing qutebrowser UI colors with the Tokyo Night palette.
* Apply consistent Tokyo Night colors to completions, downloads, hints, messages, prompts, statusbar, tabs, and webpage backgrounds.
* Keep qutebrowser's existing dark color scheme while using the same palette as the Waybar configuration.
* Use qutebrowser-supported completion background settings and a valid tab indicator color interpolation mode.
* Match pinned tabs to the corresponding unpinned tab colors and use the selected-tab colors when a pinned tab is active.
### Config: add Waybar temperature sensor
* Add a hardware-independent Waybar temperature module that reads CPU temperatures from available Linux thermal and hwmon sensors.
* Add a GPU temperature only when a supported GPU sensor is available, preferring the active display GPU and falling back to another available GPU sensor when needed.
* Place the temperature display directly after CPU usage and style it with a Tokyo Night color.
### Config: fix Waybar battery separator
* Keep the battery separators outside the battery module so they are not affected by the battery module styling.
* Show the right battery separator only when a battery power supply exists, leaving a single separator on systems without a battery.
* Apply the same separator color and spacing to both separator modules.
### Config: restore qutebrowser tabs
* Enable automatic qutebrowser session saving so open tabs are restored after reopening.
* Keep the existing qutebrowser session behavior while saving the current tabs automatically on quit.
### CHANGELOG.md: updated

## 2.0.0 - Multi-Machine Setup
### BUGFIX: restore Ollama default on sleepy
* Set the Ollama specialisation as the default systemd-boot entry on `sleepy`.
* Keep the Ollama boot default specific to `sleepy` and tolerate missing Ollama entries.
### Config: share Bash configuration with root
* Use the shared Bash configuration for both `daniel` and `root`.
* Remove the redundant Bash shebang and interactive-shell check from the shared configuration.
### Config: make Ollama the default on sleepy
* Make the Ollama specialisation the default systemd-boot entry on `sleepy`.
* Keep the Ollama boot default specific to `sleepy` so other machines are unaffected.
### Config: add multi-machine hosts
* Add the `.#sleepy` and `.#sneezy` outputs with separate hardware configurations and hostnames.
* Move machine-specific hardware configurations into `hardware/` so additional machines can be added without duplicating the shared system configuration.
* Provide Ollama as a shared physical-system specialisation instead of separate Ollama outputs for each machine.
### CHANGELOG.md: updated

## 1.6.0
### Hyprland: disable touchpad
* Detect touchpads through udev and disable them through Hyprland without relying on hardware-specific device names.
### BUGFIX: Repo contains hardware-configuration.nix again
### BUGFIX: fix printing module
* Pass `pkgs` to the printing module so the `brlaser` driver can be referenced.
### Merge remote-tracking branch 'refs/remotes/origin/main'
### Config: enable printing
* Enable the CUPS printing service.

## 1.5.0
### Config: removed hardware-configuration.nix from repo and put it in .gitignore
### BUGFIX: improve CodeCompanion tool calling with Qwen3-Coder
* Configure Qwen3-Coder with a 16K context for more reliable CodeCompanion tool calls.
* Expose CodeCompanion's built-in tools directly instead of the agent/files groups and keep tool execution in Ask mode so changes and commands require user approval.
### BUGFIX: use a valid Ollama keep-alive duration
* Set the CodeCompanion Ollama keep-alive to `-1m` so Ollama accepts it as a valid duration and keeps qwen3-coder:30b loaded indefinitely.
### BUGFIX: initialize CodeCompanion in LazyVim
* Call CodeCompanion's setup function with the configured options so the CodeCompanionChat and CodeCompanion commands are registered.
### LazyVim: configure Ollama model memory handling
* Keep the CodeCompanion qwen3-coder:30b model loaded indefinitely and unload translategemma:12b before coding requests.
* Unload qwen3-coder:30b before gen.nvim translation requests and unload translategemma:12b after each translation.
* Unload qwen3-coder:30b automatically when Neovim exits.
### LazyVim: add CodeCompanion with Qwen3-Coder
* Add CodeCompanion to LazyVim with the local Ollama model `qwen3-coder:30b` for coding assistance.
* Add `<leader>cc` for the CodeCompanion chat and `<leader>ci` for inline code assistance.
### README.md: updated
* Remove the version `v1.2.0` from the README title.
* Document the four NixOS outputs, including the manual `translategemma:12b` download required for the Ollama outputs.
* Add a key bindings section documenting the most important Hyprland shortcuts.
* Expand the Secrets import documentation for GPG keys, SSH keys, password-store and OTP secrets, and optional Rogallo data.
### LazyVim: add gen.nvim TranslateGemma prompts
* Add gen.nvim to LazyVim with the translategemma:12b model and local Ollama endpoint.
* Add the prompts "Translate to German" and "Translate to English" for replacing selected text with the translation.
### Hardware: changed hardware-configuration.nix
* Changed hardware-configuration.nix to my Tuxedo Laptop Hardware

## 1.4.0
### Config: add optional Ollama outputs
* Add the `.#ollama` output to install Ollama and run its daemon automatically on the real system.
* Add the `.#ollama-vm` output to install Ollama and run its daemon automatically in the test VM.
* Keep the existing `.#nixos` and `.#vm` outputs unchanged without Ollama.
### BUGFIX: activate right CTRL as right SUPER
* Apply the custom rctrl_mod4 XKB option in Hyprland so the right CTRL key is actually mapped to Super_R.
* Correct the XKB modifier map to assign Mod4 to the right CTRL key.
### Config: map right CTRL to right SUPER
* Map the right CTRL key to Super_R so it acts as the second SUPER key.
* Restore Print (PrtSc) to its normal Print function.
* Update custom XKB symbols and evdev rules to use rctrl_mod4 instead of print_mod4.
### Config: use Tokyo Night theme for Kitty
* Apply the Tokyo Night Night color scheme to Kitty so its background matches the general background used by Yazi and LazyVim.
* Set Kitty's foreground, cursor, selection, ANSI colors, tabs, and window borders to the Tokyo Night Night palette.
* Remove the temporary LazyGit background wrapper used by the previous LazyGit background fix.
### BUGFIX: fix LazyGit background and LazyVim Yazi layout
* Configure LazyGit to use the Tokyo Night background without changing the Kitty theme.
* Adjust the Yazi floating window in LazyVim to leave the bottom line visible for LazyVim's info line.
### Config: restore Tokyo Night theme
* Restore the Tokyo Night theme for Wofi, SwayNC, Waybar, LazyVim, Yazi, and LazyGit while keeping LazyGit's selected-window border yellow.
* Apply the Tokyo Night color scheme to GTK and Qt applications.
* Keep Kitty and Qutebrowser themes unchanged.

## 1.3.0
### BUGFIX: use LazyGit configuration in LazyVim
* Remove LazyVim's automatic LazyGit theme configuration so the custom LazyGit configuration is used in LazyVim
* Configure LazyVim to use the custom LazyGit configuration from `~/.config/lazygit/config.yml`
* Restore rounded LazyGit window borders
### LazyGit: fix LazyVim theme and borders
* Disable LazyVim's automatic LazyGit theme configuration so the custom LazyGit configuration is used in LazyVim
* Restore rounded LazyGit window borders
### LazyGit: moved configuration to config/lazygit
* Added the LazyGit configuration to `config/lazygit/config.yml`
* Moved the LazyGit configuration out of `home-lazyvim.nix` and into `home-applications.nix`
* Added a yellow active border and dark inactive borders to the LazyGit theme
### Config: changed LazyGit in LazyVim
* Changed the color scheme of LazyGit in LazyVim to stronger colors while keeping the "adwaita-dark" theme
### Config: changed hypr/hyprland.lua
* Added keys (SUPER + [H,J,K,L]) to swap windows in specific direction
### Config: changed rogallo config and bashrc
* Changed the Gopher Marker for images to "IMG "
* Added "export BROWSER=qutebrowser" to bashrc
### Config: use Adwaita-dark styles
* Update Wofi, Kitty, Yazi, SwayNC, Waybar, and LazyVim to use an Adwaita-dark color palette.
* Replace the previous Tokyo Night colors with Adwaita colors throughout the desktop and editor configuration.
* Keep the existing layouts, spacing, keybindings, and application behavior unchanged.
* Add the LazyVim Adwaita colorscheme configuration.

## 1.2.0
### README: update application list
* Remove obsolete Alacritty and Ranger entries.
* Add Yazi to the listed user applications.
### LazyVim: integrate Yazi with Kitty
* Use yazi.nvim for the LazyVim Yazi integration while keeping Yazi in a native Kitty window for direct image previews.
* Keep Yazi's text and code previews with syntax highlighting when launched from LazyVim.
* Disable image and PDF previews only for the LazyVim-specific Yazi configuration.
* Keep the 90% Yazi floating window and explicit arrow-key navigation.
* Remove obsolete Ranger integration, configuration files, and related keymaps.
* Remove the no-longer-needed ueberzugpp dependency after disabling image previews in LazyVim.
* Add the Bash shebang and create the configured user Downloads directory.
### LazyVim: use Yazi with Kitty
* Run Yazi in a normal Kitty window for native image previews.
* Launch Yazi through a Nix-generated wrapper so the regular `yazi` command uses Kitty without recursively invoking the wrapper.
* Remove the Hyprland floating rule for Yazi.
* Open files selected in Yazi as LazyVim buffers and keep explicit arrow-key navigation.
* Bind Yazi to <Leader>+r in LazyVim's global keymaps so the mapping remains available after LazyVim loads.
* Set the Yazi column ratio to 2:3:4.
* Remove Alacritty and use Kitty as the terminal.
* Add ueberzugpp for Yazi image previews in Wayland/Neovim.
* Open Yazi in a 90% floating window inside LazyVim.
### Config: fix NixOS configuration
* Install the Ranger configuration through Home Manager.
* Remove unused Qutebrowser configuration files.
* Fix Bash configuration to use programs from PATH instead of /usr/bin.
* Use Neovim as Qutebrowser's editor.
### Config: Create ~/Downloads
* This creates a "Downloads" folder and all other user directories in the configured language.
* The "Downloads" folder always remains "Downloads", regardless of the configured language.

## 1.1.0
### LazyVim: improved Ranger integration
* Enlarged the rnvimr floating window to leave only one character of margin.
* Use Enter instead of E to open files in LazyVim.
* Open selected files as LazyVim buffers and close Ranger after picking.
### Config: clean up and update desktop configuration
* remove obsolete Alacritty configuration
* clean up Ranger configuration and remove unused files
* merge and simplify Qutebrowser configuration
* update Waybar styling to Tokyo Night colors
* update Wofi styling to Tokyo Night colors
* reduce Wofi input height without changing font size
* clean up Hyprland configuration
* simplify dropdown terminal configuration
* fix various configuration errors and inconsistencies
### LazyVim: use mvimr for Ranger
### LazyVim: deploy mvimr plugin configuration
### LazyVim: add mvimr Ranger integration
### README.md fixed
* Removed the comment "focused on reproducibility", because flake.lock is in .gitignore and a build always uses the newest NixOS packages.
### Config: LazyGit - Added function for git-push-all
* Added a LazyGit function ("CTRL+y") to push to all remotes
### Config: Networking firewall activated
* Activated network firewall in all-network.nix
### Config: Changed home-gpg.nix to home-ssh-gpg.nix
* Added ssh and ssh-agent to keep once used secret key passwords for 24h
* gpg now also keeps secret key passwords for 24h
### README.md updated
### README.md updated
### Security: Added "rogallo" directory to secrets
* The Directory "rogallo" was added to the secrets, which may contain Client Certificates with secret keys, bookmarks, history and a few other things.
### Added: jq, wev, pipx, gemget, rogallo, gtl
* all-packages.nix: jq, wev
* home-packages: pipx, gemget
* pipx: rogallo (TUI Gemini Browser)
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
* Added .luac.json for hyprland.lua to the repository root
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
* Split original home.nix in home.nix and a few modules under "./modules": home-applications.nix, home-desktop.nix, home-gpg.nix, home-lazyvim.nix, home-packages.nix, home-private.nix, home-shell.nix
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
* This installs a "$HOME/bin" directory, which is handled by the NixOS config, so to place programs in ~/bin, you have to add them to the config/bin directory in the NixOS configuration.

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
* Added `librewolf` to the home.nix programs
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
