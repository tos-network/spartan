# Release Guide

This document describes how to create automated releases for Spartan.

## Automatic Release Process

When you push a version tag (e.g., `v0.0.8`), GitHub Actions automatically:
1. Creates a GitHub Release
2. Builds packages for all platforms:
   - Android (APK)
   - Linux (tar.gz)
   - Windows (MSIX)
   - macOS (ZIP)
3. Uploads all built packages to the release

## How to Create a Release

### Method 1: Using the release script (Recommended)

```bash
# Use version from pubspec.yaml
./release.sh

# Or specify a version
./release.sh 0.0.9
```

### Method 2: Manual tag creation

```bash
# 1. Make sure your code is committed
git add .
git commit -m "Prepare for release v0.0.9"

# 2. Update version in pubspec.yaml if needed
# Edit pubspec.yaml and change: version: 0.0.9

# 3. Commit version change
git add pubspec.yaml
git commit -m "Bump version to 0.0.9"

# 4. Create and push tag
git tag -a v0.0.9 -m "Release v0.0.9"
git push origin master
git push origin v0.0.9
```

## Monitoring the Build

After pushing the tag:
1. Go to your GitHub repository
2. Click on "Actions" tab
3. Look for the "Release Builds" workflow
4. Monitor the build progress for each platform

## Download Releases

Once the build completes:
1. Go to your GitHub repository
2. Click on "Releases" tab
3. Find your version (e.g., v0.0.9)
4. Download the platform-specific packages:
   - `spartan-0.0.9-android.apk` - Android
   - `spartan-0.0.9-linux-x64.tar.gz` - Linux
   - `spartan-0.0.9-windows.msix` - Windows
   - `spartan-0.0.9-macos.zip` - macOS

## Build Time

Typical build times:
- Android: ~10-15 minutes
- Linux: ~10-15 minutes
- Windows: ~15-20 minutes
- macOS: ~15-20 minutes

Total: ~20-30 minutes for all platforms (builds run in parallel)

## Troubleshooting

If a build fails:
1. Check the Actions logs for error messages
2. You can manually trigger individual platform builds using the existing workflows:
   - `.github/workflows/build_android.yml`
   - `.github/workflows/build_linux.yml`
   - `.github/workflows/build_windows.yml`
   - `.github/workflows/build_macos.yml`

## Notes

- Make sure the version in `pubspec.yaml` matches the tag version
- Tags must start with 'v' (e.g., v0.0.9, v1.0.0)
- Once a tag is pushed, it cannot be easily changed - be sure before pushing
- Pre-release versions (e.g., v0.0.9-beta) are also supported
