#!/bin/bash

# Check Release Build Status
# A simple script to check the status of the latest release workflow

echo "🚀 Checking Release Build Status..."
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI not installed. Please visit:"
    echo "   https://github.com/tos-network/spartan/actions"
    echo ""
    echo "Or install gh CLI:"
    echo "   brew install gh"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null 2>&1; then
    echo "⚠️  Not authenticated. Please visit:"
    echo "   https://github.com/tos-network/spartan/actions"
    echo ""
    echo "Or authenticate:"
    echo "   gh auth login"
    exit 1
fi

echo "Latest workflow runs:"
echo ""
gh run list --workflow="Release Builds" --limit 5

echo ""
echo "─────────────────────────────────────────"
echo ""

# Get the latest run
LATEST_RUN=$(gh run list --workflow="Release Builds" --limit 1 --json databaseId,status,conclusion,createdAt,displayTitle -q '.[0]')

if [ -z "$LATEST_RUN" ]; then
    echo "No workflow runs found."
    exit 0
fi

RUN_ID=$(echo "$LATEST_RUN" | jq -r '.databaseId')
STATUS=$(echo "$LATEST_RUN" | jq -r '.status')
CONCLUSION=$(echo "$LATEST_RUN" | jq -r '.conclusion')
TITLE=$(echo "$LATEST_RUN" | jq -r '.displayTitle')
CREATED=$(echo "$LATEST_RUN" | jq -r '.createdAt')

echo "Latest Run Details:"
echo "  Title: $TITLE"
echo "  Status: $STATUS"
echo "  Conclusion: $CONCLUSION"
echo "  Created: $CREATED"
echo "  Run ID: $RUN_ID"
echo ""
echo "View details: https://github.com/tos-network/spartan/actions/runs/$RUN_ID"
echo ""

# Watch the run if it's in progress
if [ "$STATUS" = "in_progress" ] || [ "$STATUS" = "queued" ]; then
    echo "─────────────────────────────────────────"
    echo ""
    read -p "Watch this run? (y/n): " watch
    if [ "$watch" = "y" ]; then
        gh run watch "$RUN_ID"
    fi
fi
