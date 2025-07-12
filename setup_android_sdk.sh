#!/bin/bash

# Android SDK Setup Script
# This script automates the setup of Android SDK for building Android projects

set -e  # Exit on any error

echo "🚀 Starting Android SDK setup..."

# Configuration
ANDROID_SDK_ROOT="/opt/android-sdk"
CMDLINE_TOOLS_VERSION="11076708"
CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip"
PLATFORM_VERSION="34"
BUILD_TOOLS_VERSION="34.0.0"

# Install Java 17 if not already installed
echo "☕ Installing Java 17..."
if ! dpkg -s openjdk-17-jdk >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y openjdk-17-jdk
fi

# Set Java 17 as default
echo "🔧 Setting Java 17 as default..."
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=/usr/lib/jvm/java-17-openjdk-amd64/bin:$PATH

# Create SDK directory
echo "📁 Creating Android SDK directory..."
sudo mkdir -p $ANDROID_SDK_ROOT
cd $ANDROID_SDK_ROOT

# Download command line tools if not already present
if [ ! -f "cmdline-tools.zip" ]; then
    echo "⬇️  Downloading Android Command Line Tools..."
    sudo wget $CMDLINE_TOOLS_URL -O cmdline-tools.zip
fi

# Extract and organize command line tools
if [ ! -d "cmdline-tools/latest" ]; then
    echo "📦 Extracting command line tools..."
    sudo unzip -q cmdline-tools.zip
    sudo mkdir -p cmdline-tools
    sudo mv cmdline-tools latest
    sudo mv latest cmdline-tools/
fi

# Set permissions
echo "🔐 Setting permissions..."
sudo chmod +x cmdline-tools/latest/bin/*

# Set environment variables
echo "🌍 Setting environment variables..."
export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Create environment setup file
echo "📝 Creating environment setup file..."
sudo tee /etc/environment.d/android-sdk.conf > /dev/null << EOF
JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ANDROID_HOME=$ANDROID_SDK_ROOT
ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT
PATH=/usr/lib/jvm/java-17-openjdk-amd64/bin:\$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools
EOF

# Accept licenses non-interactively
echo "📜 Accepting Android SDK licenses..."
yes | sudo -E cmdline-tools/latest/bin/sdkmanager --licenses || true

# Install required SDK components
echo "⚙️  Installing SDK components..."
sudo -E cmdline-tools/latest/bin/sdkmanager --install \
    "platform-tools" \
    "platforms;android-${PLATFORM_VERSION}" \
    "build-tools;${BUILD_TOOLS_VERSION}" \
    "cmdline-tools;latest"

# Install additional useful components
echo "🔧 Installing additional components..."
sudo -E cmdline-tools/latest/bin/sdkmanager --install \
    "extras;android;m2repository" \
    "extras;google;m2repository" || true

# Create local.properties file in workspace
echo "📋 Creating local.properties file..."
echo "sdk.dir=$ANDROID_SDK_ROOT" | sudo tee /workspace/local.properties > /dev/null

# Set ownership to current user
echo "👤 Setting proper ownership..."
sudo chown -R $(whoami):$(whoami) $ANDROID_SDK_ROOT /workspace/local.properties 2>/dev/null || true

# Verify installation
echo "✅ Verifying installation..."
if [ -f "$ANDROID_SDK_ROOT/platform-tools/adb" ]; then
    echo "✓ Platform tools installed successfully"
else
    echo "❌ Platform tools installation failed"
    exit 1
fi

if [ -d "$ANDROID_SDK_ROOT/platforms/android-${PLATFORM_VERSION}" ]; then
    echo "✓ Android platform ${PLATFORM_VERSION} installed successfully"
else
    echo "❌ Android platform installation failed"
    exit 1
fi

if [ -d "$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS_VERSION}" ]; then
    echo "✓ Build tools ${BUILD_TOOLS_VERSION} installed successfully"
else
    echo "❌ Build tools installation failed"
    exit 1
fi

echo ""
echo "🎉 Android SDK setup completed successfully!"
echo ""
echo "📍 SDK Location: $ANDROID_SDK_ROOT"
echo "📱 Platform Version: android-${PLATFORM_VERSION}"
echo "🔨 Build Tools Version: ${BUILD_TOOLS_VERSION}"
echo ""
echo "💡 To use in new shells, run: source /etc/environment.d/android-sdk.conf"
echo ""