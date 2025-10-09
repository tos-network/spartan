#!/bin/bash

# GitHub Actions Workflow Runs Cleanup Script
# This script helps you delete old or failed workflow runs

echo "GitHub Actions Workflow Runs Cleanup"
echo "====================================="
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI (gh) is not installed."
    echo ""
    echo "Installation options:"
    echo ""
    echo "macOS:"
    echo "  brew install gh"
    echo ""
    echo "Linux:"
    echo "  See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    echo ""
    echo "After installation, run: gh auth login"
    echo ""
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "⚠️  Not authenticated with GitHub CLI"
    echo "Run: gh auth login"
    exit 1
fi

echo "Available cleanup options:"
echo ""
echo "1. Delete all failed workflow runs"
echo "2. Delete all workflow runs (including successful)"
echo "3. Delete workflow runs older than 30 days"
echo "4. Delete workflow runs for a specific workflow"
echo "5. Exit"
echo ""
read -p "Choose an option (1-5): " option

case $option in
    1)
        echo ""
        echo "🗑️  Deleting all failed workflow runs..."
        gh run list --status failure --limit 100 --json databaseId --jq '.[].databaseId' | \
        while read -r run_id; do
            echo "Deleting run $run_id..."
            gh run delete "$run_id" || true
        done
        echo "✅ Done!"
        ;;

    2)
        echo ""
        read -p "⚠️  This will delete ALL workflow runs. Are you sure? (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            echo "🗑️  Deleting all workflow runs..."
            gh run list --limit 1000 --json databaseId --jq '.[].databaseId' | \
            while read -r run_id; do
                echo "Deleting run $run_id..."
                gh run delete "$run_id" || true
            done
            echo "✅ Done!"
        else
            echo "Cancelled."
        fi
        ;;

    3)
        echo ""
        echo "🗑️  Deleting workflow runs older than 30 days..."
        # GitHub CLI doesn't have a direct date filter, but we can use created timestamp
        gh run list --limit 1000 --json databaseId,createdAt --jq '.[] | select(.createdAt < (now - 30*24*3600 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .databaseId' | \
        while read -r run_id; do
            echo "Deleting run $run_id..."
            gh run delete "$run_id" || true
        done
        echo "✅ Done!"
        ;;

    4)
        echo ""
        echo "Available workflows:"
        gh workflow list
        echo ""
        read -p "Enter workflow name (e.g., 'Release Builds'): " workflow_name
        echo "🗑️  Deleting runs for workflow: $workflow_name"
        gh run list --workflow="$workflow_name" --limit 100 --json databaseId --jq '.[].databaseId' | \
        while read -r run_id; do
            echo "Deleting run $run_id..."
            gh run delete "$run_id" || true
        done
        echo "✅ Done!"
        ;;

    5)
        echo "Exiting..."
        exit 0
        ;;

    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "Current workflow runs:"
gh run list --limit 10
