# Testing GitHub Actions Workflows Locally

This guide explains how to test GitHub Actions workflows locally before pushing to GitHub.

## Prerequisites

1. **Docker Desktop** must be running
   ```bash
   # Check if Docker is running
   docker info
   ```

2. **act** tool (already installed via Homebrew)
   ```bash
   act --version
   ```

## Quick Start

### Method 1: Using the test script (Easiest)

```bash
# List all jobs in the release workflow
./test-workflow.sh

# Test a specific job
./test-workflow.sh build-android
./test-workflow.sh build-linux
./test-workflow.sh build-windows
./test-workflow.sh build-macos
```

### Method 2: Using act directly

```bash
# List all workflows
act --list

# List jobs in release workflow
act push -W .github/workflows/release.yml --list

# Test a specific job (dry-run, shows what would run)
act push -W .github/workflows/release.yml -j build-android --dry-run

# Actually run a specific job
act push -W .github/workflows/release.yml -j build-android

# Run all jobs in the release workflow
act push -W .github/workflows/release.yml
```

## Important Notes

### Limitations

1. **Platform Differences**
   - `act` runs jobs in Docker containers on Linux
   - Windows and macOS runners are simulated using Linux containers
   - Some platform-specific features may not work exactly as on GitHub

2. **Build Time**
   - First run will be slow (downloads Docker images)
   - Subsequent runs are faster (cached images)
   - Installing dependencies (Rust, Flutter, etc.) takes time

3. **Resource Usage**
   - Builds require significant disk space and memory
   - Make sure Docker has enough resources allocated
   - Recommended: 8GB RAM, 50GB disk space for Docker

### What Works Well

✅ Syntax validation
✅ Step execution order
✅ Environment variables
✅ Basic build commands
✅ Artifact creation (locally)

### What Doesn't Work Perfectly

⚠️ Platform-specific builds (Windows/macOS on Linux containers)
⚠️ GitHub secrets (need to provide via `.secrets` file)
⚠️ Some GitHub-specific features
⚠️ Upload to GitHub Releases

## Recommended Testing Strategy

Instead of testing full builds locally (which is slow and may not be accurate), use this approach:

### 1. Test Individual Build Steps

Test the workflow steps manually to ensure they work:

```bash
# Test the exact sequence from the workflow
flutter pub get
flutter_rust_bridge_codegen generate
dart run build_runner build -d
flutter build apk --release  # or other platform
```

### 2. Use act for Workflow Structure Validation

Use `act` to validate:
- Workflow syntax
- Job dependencies
- Step ordering
- Environment setup

```bash
# Dry-run to check structure
act push -W .github/workflows/release.yml --dry-run
```

### 3. Test on GitHub with Draft Releases

For final validation:
- Create a test tag: `git tag v0.0.0-test`
- Push it to trigger the workflow
- Check if everything works
- Delete the release and tag if needed

## Quick Validation Commands

```bash
# 1. Validate workflow syntax
act --list

# 2. Check what would run for a tag push
act push -W .github/workflows/release.yml --list

# 3. Test individual steps manually
just init  # Uses justfile to run initialization steps

# 4. Build for your current platform
flutter build apk --release      # Android
flutter build linux --release    # Linux
flutter build windows --release  # Windows (on Windows)
flutter build macos --release    # macOS (on macOS)
```

## Troubleshooting

### Docker not running
```bash
# Start Docker Desktop manually, or:
open -a Docker
```

### act fails to pull images
```bash
# Manually pull the required image
docker pull catthehacker/ubuntu:act-latest
```

### Out of disk space
```bash
# Clean up Docker
docker system prune -a
```

### Workflow changes not reflected
```bash
# act caches workflows, force refresh by:
rm -rf ~/.cache/act
```

## Configuration

The `.actrc` file in the project root configures which Docker images to use for each runner type. You can customize this if needed.

## Additional Resources

- act documentation: https://github.com/nektos/act
- GitHub Actions syntax: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions
