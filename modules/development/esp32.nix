{ pkgs, lib, ... }:

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
    IDF_TARGET = "esp32";
    ESP_IDF_VERSION = "tag:v5.1.4";
  };

  environment.extraInit = ''
    export LD_LIBRARY_PATH="${
      lib.makeLibraryPath [
        pkgs.zlib
        pkgs.stdenv.cc.cc.lib
        pkgs.libxml2_13
      ]
    }''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    export IDF_TARGET=esp32
    export ESP_IDF_VERSION=tag:v5.1.4
  '';
}
