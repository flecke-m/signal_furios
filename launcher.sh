#!/bin/bash

# Signal FuriOS launcher for Debian
export APP_DIR=/opt/signalfurios
export CONFIG_DIR=$HOME/.config/signalfurios
export DATA_DIR=$HOME/.local/share/signalfurios
export CACHE_DIR=$HOME/.cache/signalfurios

# Create necessary directories
mkdir -p "$CONFIG_DIR"
mkdir -p "$DATA_DIR"
mkdir -p "$CACHE_DIR"

# Set environment variables for proper GTK/Qt integration
export XDG_CONFIG_HOME="$CONFIG_DIR"
export XDG_DATA_HOME="$DATA_DIR"
export XDG_CACHE_HOME="$CACHE_DIR"

# GTK and Qt environment
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export GDK_BACKEND=x11
export DISABLE_WAYLAND=1

# Signal specific environment
export SIGNAL_DATA_DIR="$DATA_DIR"
export SIGNAL_CONFIG_DIR="$CONFIG_DIR"

# Launch Signal
cd "$APP_DIR"
exec ./signal-desktop --no-sandbox
