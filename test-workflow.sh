#!/bin/bash

# Script to test GitHub Actions workflows locally using act
# Usage: ./test-workflow.sh [job_name]

set -e

echo "🧪 Testing GitHub Actions Workflow Locally"
echo ""

# Check if act is installed
if ! command -v act &> /dev/null; then
    echo "❌ 'act' is not installed. Install it with: brew install act"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    echo ""
    echo "To start Docker:"
    echo "  1. Open Docker Desktop app"
    echo "  2. Wait for it to fully start"
    echo "  3. Run this script again"
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Detect Apple Silicon and set architecture flag
ARCH_FLAG=""
if [[ $(uname -m) == "arm64" ]]; then
    echo "🍎 Detected Apple Silicon (M-series chip)"
    ARCH_FLAG="--container-architecture linux/amd64"
    echo ""
fi

echo "Available commands:"
echo "  list       - List all jobs in the release workflow"
echo "  validate   - Validate workflow syntax (dry-run)"
echo "  android    - Test Android build job"
echo "  linux      - Test Linux build job"
echo "  windows    - Test Windows build job"
echo "  macos      - Test macOS build job"
echo "  all        - Test all jobs (takes a long time!)"
echo ""

# Get command from argument or ask user
if [ -z "$1" ]; then
    read -p "Enter command (default: list): " COMMAND
    COMMAND=${COMMAND:-list}
else
    COMMAND=$1
fi

case "$COMMAND" in
    list)
        echo "📋 Listing all jobs in release workflow..."
        act push -W .github/workflows/release.yml --list $ARCH_FLAG
        ;;
    validate)
        echo "✅ Validating workflow syntax..."
        act push -W .github/workflows/release.yml --dry-run $ARCH_FLAG
        ;;
    android)
        echo "🤖 Testing Android build job..."
        echo "⚠️  Note: This runs in a Docker container and may take 15-30 minutes..."
        act push -W .github/workflows/release.yml -j build-android $ARCH_FLAG --verbose
        ;;
    linux)
        echo "🐧 Testing Linux build job..."
        echo "⚠️  Note: This runs in a Docker container and may take 15-30 minutes..."
        act push -W .github/workflows/release.yml -j build-linux $ARCH_FLAG --verbose
        ;;
    windows)
        echo "🪟 Testing Windows build job..."
        echo "⚠️  Note: This runs in a Docker container and may take 15-30 minutes..."
        act push -W .github/workflows/release.yml -j build-windows $ARCH_FLAG --verbose
        ;;
    macos)
        echo "🍎 Testing macOS build job..."
        echo "⚠️  Note: This runs in a Docker container and may take 15-30 minutes..."
        act push -W .github/workflows/release.yml -j build-macos $ARCH_FLAG --verbose
        ;;
    all)
        echo "🚀 Testing ALL jobs in release workflow..."
        echo "⚠️  WARNING: This will take 30-60 minutes and use significant resources!"
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            act push -W .github/workflows/release.yml $ARCH_FLAG --verbose
        else
            echo "Cancelled."
            exit 0
        fi
        ;;
    *)
        echo "❌ Unknown command: $COMMAND"
        echo "Valid commands: list, validate, android, linux, windows, macos, all"
        exit 1
        ;;
esac

echo ""
echo "✅ Test completed!"
