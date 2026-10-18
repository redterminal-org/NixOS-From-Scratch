#!/usr/bin/env bash

# install minimal toolchain v1.99.1
rustup toolchain install 1.99.1 --profile minimal
RUSTUP_TOOLCHAIN=1.99.1 cargo install espup --version 0.18.0 --locked --force
${HOME}/.cargo/bin/espup update --targets esp32 --export-file "${HOME}/.cargo/export-esp.sh"
RUSTUP_TOOLCHAIN=1.99.1 cargo install espflash

echo "-- Rust for ESP32 install complete --"
echo "You need to reboot or do 'source ~/.bashrc' to activate."
