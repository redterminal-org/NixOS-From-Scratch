{
  # QuteBrowser Configuration
  home.file.".config/qutebrowser/config.py".source =
    ../config/qutebrowser/config.py;
  home.file.".config/qutebrowser/base16_gruvbox_dark_hard.py".source =
    ../config/qutebrowser/base16_gruvbox_dark_hard.py;
  home.file.".config/qutebrowser/autoconfig.yml".source =
    ../config/qutebrowser/autoconfig.yml;

  # Other programs
  home.file.".config/alacritty".source = ../config/alacritty;
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

    # Display JSON as plain text.
    application/json; cat %s; copiousoutput

    # Display calendar data as plain text.
    text/calendar; cat %s; copiousoutput
  '';

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web
      "text/html" = "qutebrowser.desktop";
      "application/xhtml+xml" = "qutebrowser.desktop";
      "x-scheme-handler/http" = "qutebrowser.desktop";
      "x-scheme-handler/https" = "qutebrowser.desktop";

      # PDF
      "application/pdf" = "org.pwmt.zathura.desktop";

      # Plain text
      "text/plain" = "qutebrowser.desktop";

      # XML
      "application/xml" = "qutebrowser.desktop";
      "text/xml" = "qutebrowser.desktop";

      # JSON
      "application/json" = "qutebrowser.desktop";

      # Images
      "image/png" = "qutebrowser.desktop";
      "image/jpeg" = "qutebrowser.desktop";
      "image/gif" = "qutebrowser.desktop";
      "image/webp" = "qutebrowser.desktop";
      "image/svg+xml" = "qutebrowser.desktop";

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

}
