{ pkgs, lib, ... }:

let
  toolchainDir = "/var/lib/esp32-dev";

  esp32LibraryPath = lib.makeLibraryPath [
    pkgs.zlib
    pkgs.stdenv.cc.cc.lib
    pkgs.libxml2_13
  ];
in
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      libxml2_13
      openssl
      ncurses
      libffi
      libusb1
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    cmake
    gnumake
    ninja
    pkg-config
    python3
    rustup
    clang
    lld
    esptool
    bison
    ccache
    curl
    flex
    gcc
    gperf
    libffi
    libusb1
    llvmPackages.libclang
    ncurses
    openssl
    perl
    wget
    which
    zlib
    ldproxy
  ];

  environment.sessionVariables = {
    RUSTUP_HOME = "${toolchainDir}/rustup";
    RUSTUP_TOOLCHAIN = "esp";
    IDF_TARGET = "esp32";
    ESP_IDF_VERSION = "tag:v5.1.4";
  };

  environment.extraInit = ''
    export PATH="${toolchainDir}/cargo/bin:$PATH"

    if [ -r "${toolchainDir}/export-esp.sh" ]; then
      . "${toolchainDir}/export-esp.sh"
    fi

    export LD_LIBRARY_PATH="${
      lib.makeLibraryPath [
        pkgs.zlib
        pkgs.stdenv.cc.cc.lib
        pkgs.libxml2_13
      ]
    }''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    export RUSTUP_HOME="${toolchainDir}/rustup"
    export RUSTUP_TOOLCHAIN=esp
    export IDF_TARGET=esp32
    export ESP_IDF_VERSION=tag:v5.1.4
  '';

  system.activationScripts.esp32DevToolchain = {
    deps = [ "etc" ];
    text = ''
      set -eu

      toolchain_dir="${toolchainDir}"
      export RUSTUP_HOME="$toolchain_dir/rustup"
      export CARGO_HOME="$toolchain_dir/cargo"
      export PATH="${
        lib.makeBinPath [
          pkgs.rustup
          pkgs.curl
          pkgs.git
          pkgs.gcc
          pkgs.gnumake
          pkgs.pkg-config
          pkgs.openssl
          pkgs.perl
          pkgs.bash
          pkgs.gnutar
          pkgs.xz
          pkgs.gzip
          pkgs.coreutils
          pkgs.findutils
          pkgs.gnugrep
          pkgs.gnused
          pkgs.gawk
          pkgs.which
        ]
      }:$CARGO_HOME/bin:$PATH"

      mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"

      if [ "$(cat "$toolchain_dir/espup-version" 2>/dev/null || true)" != "0.18.0" ] || [ ! -s "$toolchain_dir/export-esp.sh" ]; then
        rustup toolchain install 1.99.1 --profile minimal
        RUSTUP_TOOLCHAIN=1.99.1 cargo install espup --version 0.18.0 --locked --force

        if [ -s "$toolchain_dir/export-esp.sh" ]; then
          "$CARGO_HOME/bin/espup" update \
            --targets esp32 \
            --export-file "$toolchain_dir/export-esp.sh"
        else
          "$CARGO_HOME/bin/espup" install \
            --targets esp32 \
            --export-file "$toolchain_dir/export-esp.sh"
        fi

        printf '%s\\n' "0.18.0" > "$toolchain_dir/espup-version"
        chmod -R a+rX "$toolchain_dir"
      fi
    '';
  };
}
