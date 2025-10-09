#!/bin/bash

# Script to create and push a new release tag
# Usage: ./release.sh [version]
# Example: ./release.sh 0.0.9

set -e

# Get version from argument or from pubspec.yaml
if [ -z "$1" ]; then
  VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
  echo "No version specified, using version from pubspec.yaml: $VERSION"
else
  VERSION=$1
  echo "Using specified version: $VERSION"
fi

TAG="v$VERSION"

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Error: Tag $TAG already exists!"
  exit 1
fi

# Show current git status
echo ""
echo "Current git status:"
git status --short

# Confirm release
echo ""
echo "This will create and push tag: $TAG"
read -p "Continue? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Release cancelled."
  exit 1
fi

# Create and push tag
echo "Creating tag $TAG..."
git tag -a "$TAG" -m "Release $TAG"

echo "Pushing tag to GitHub..."
git push origin "$TAG"

echo ""
echo "✓ Tag $TAG pushed successfully!"
echo "GitHub Actions will now build releases for all platforms."
echo "Check progress at: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions"
