{ config, pkgs, ... }:

{
  # QuteBrowser Configuration
  home.file.".config/qutebrowser/config.py".source = ../config/qutebrowser/config.py;
  home.file.".config/qutebrowser/base16_gruvbox_dark_hard.py".source =
    ../config/qutebrowser/base16_gruvbox_dark_hard.py;

  home.file.".config/qutebrowser/linuxcult-ca.pem".source = ../config/qutebrowser/linuxcult-ca.pem;

  home.activation.installQutebrowserCA = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    nssdb="$HOME/.pki/nssdb"
    ca="${../config/qutebrowser/linuxcult-ca.pem}"
    nickname="LinuxCult.net"

    mkdir -p "$nssdb"

    if [ ! -f "$nssdb/cert9.db" ]; then
      ${pkgs.nssTools}/bin/certutil -N -d "sql:$nssdb" --empty-password
    fi

    source_fingerprint="$(
      ${pkgs.openssl}/bin/openssl x509 -in "$ca" -noout -fingerprint -sha256
    )"

    if ${pkgs.nssTools}/bin/certutil -L -d "sql:$nssdb" -n "$nickname" >/dev/null 2>&1; then
      installed_fingerprint="$(
        ${pkgs.nssTools}/bin/certutil -L -d "sql:$nssdb" -n "$nickname" -a |
        ${pkgs.openssl}/bin/openssl x509 -noout -fingerprint -sha256
      )"
    else
      installed_fingerprint=""
    fi

    if [ "$source_fingerprint" != "$installed_fingerprint" ]; then
      ${pkgs.nssTools}/bin/certutil -D -d "sql:$nssdb" -n "$nickname" >/dev/null 2>&1 || true
      ${pkgs.nssTools}/bin/certutil -A -d "sql:$nssdb" -i "$ca" -n "$nickname" -t "TC,C,T"
    fi
  '';

  # Other programs
  home.file.".config/kitty".source = ../config/kitty;
  home.file.".config/yazi".source = ../config/yazi;
  home.file.".config/tmux".source = ../config/tmux;
  home.file.".config/yazi-lazyvim/yazi.toml".source = ../config/yazi-lazyvim/yazi.toml;
  home.file.".config/yazi-lazyvim/keymap.toml".source = ../config/yazi-lazyvim/keymap.toml;
  home.file.".config/yazi-lazyvim/theme.toml".source = ../config/yazi-lazyvim/theme.toml;
  home.file.".local/bin/yazi" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      exec ${pkgs.kitty}/bin/kitty --class yazi ${pkgs.yazi}/bin/yazi "$@"
    '';
    executable = true;
  };
  home.file.".config/lazygit/config.yml".source = ../config/lazygit/config.yml;
  home.file.".config/eza".source = ../config/eza;
  home.file.".config/starship.toml".source = ../config/starship.toml;
  home.file.".config/todo".source = ../config/todo;
  home.file.".config/Xresources".source = ../config/Xresources;

  # Configure MIME handlers for NeoMutt.
  home.file.".mailcap".text = ''
    # Render HTML inline in the NeoMutt pager.
    text/html; elinks -dump -no-home %s; nametemplate=%s.html; copiousoutput

    # Display plain text directly.
    text/plain; cat %s; copiousoutput

    # Display XML as plain text.
    application/xml; cat %s; copiousoutput
    text/xml; cat %s; copiousoutput

    # Display PDF in zathura
    application/pdf; zathura %s

    # Display JSON as plain text.
    application/json; cat %s; copiousoutput

    # Display calendar data as plain text.
    text/calendar; cat %s; copiousoutput
  '';

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web
      "text/html" = "qutebrowser-xdg.desktop";
      "application/xhtml+xml" = "qutebrowser-xdg.desktop";
      "x-scheme-handler/http" = "qutebrowser-xdg.desktop";
      "x-scheme-handler/https" = "qutebrowser-xdg.desktop";

      # PDF
      "application/pdf" = "org.pwmt.zathura.desktop";

      # Plain text
      "text/plain" = "qutebrowser-xdg.desktop";

      # XML
      "application/xml" = "qutebrowser-xdg.desktop";
      "text/xml" = "qutebrowser-xdg.desktop";

      # JSON
      "application/json" = "qutebrowser-xdg.desktop";

      # Images
      "image/png" = "qutebrowser-xdg.desktop";
      "image/jpeg" = "qutebrowser-xdg.desktop";
      "image/gif" = "qutebrowser-xdg.desktop";
      "image/webp" = "qutebrowser-xdg.desktop";
      "image/svg+xml" = "qutebrowser-xdg.desktop";

      # Audio
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";

      # Video
      "video/mp4" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";

      # Archives
      "application/zip" = "dolphin.desktop";
      "application/x-7z-compressed" = "dolphin.desktop";
      "application/x-rar" = "dolphin.desktop";
      "application/x-tar" = "dolphin.desktop";
      "application/gzip" = "dolphin.desktop";
      "application/x-bzip2" = "dolphin.desktop";
      "application/x-xz" = "dolphin.desktop";

      # Directories
      "inode/directory" = "org.kde.dolphin.desktop";
    };
  };

  xdg.desktopEntries.qutebrowser-xdg = {
    name = "Qutebrowser (XDG)";
    genericName = "Web Browser";
    exec = "qutebrowser --target tab %U";
    terminal = false;
    type = "Application";

    mimeType = [
      "text/html"
      "application/xhtml+xml"
      "image/png"
      "image/jpeg"
      "image/gif"
      "image/webp"
      "image/svg+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];

    categories = [
      "Network"
      "WebBrowser"
    ];
  };

  home.activation.copyGTLConfigFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    target="${config.home.homeDirectory}/.config/gtl"
    sourceRoot="${../config/gtl}"

    mkdir -p "$target"

    ${pkgs.findutils}/bin/find "$sourceRoot" -type f -exec sh -c '
      root="$1"
      target="$2"
      shift 2

      for source; do
        relative="''${source#"$root"/}"
        destination="$target/$relative"

        if [ ! -e "$destination" ]; then
          mkdir -p "$(dirname "$destination")"
          cp "$source" "$destination"
        fi

        chmod 644 "$destination"
      done
    ' sh "$sourceRoot" "$target" {} +
  '';

  home.activation.copyRogalloConfigFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    target="${config.home.homeDirectory}/.config/rogallo"
    sourceRoot="${../config/rogallo}"

    mkdir -p "$target"

    ${pkgs.findutils}/bin/find "$sourceRoot" -type f -exec sh -c '
      root="$1"
      target="$2"
      shift 2

      for source; do
        relative="''${source#"$root"/}"
        destination="$target/$relative"

        if [ ! -e "$destination" ]; then
          mkdir -p "$(dirname "$destination")"
          cp "$source" "$destination"
        fi

        chmod 644 "$destination"
      done
    ' sh "$sourceRoot" "$target" {} +
  '';
}
