#!/bin/bash

# Script to demonstrate cloning upstream master as local-master
# and cherry-picking a commit from local-fork

set -e

echo "=== Cherry-Pick Setup Script ==="
echo ""

# Step 1: Add upstream remote
echo "Step 1: Adding upstream remote (louislam/uptime-kuma)..."
if ! git remote get-url upstream &>/dev/null; then
    git remote add upstream https://github.com/louislam/uptime-kuma.git
    echo "✓ Upstream remote added"
else
    echo "✓ Upstream remote already exists"
fi
echo ""

# Step 2: Fetch upstream master
echo "Step 2: Fetching upstream master branch..."
git fetch upstream master --depth=10
echo "✓ Upstream master fetched"
echo ""

# Step 3: Create local-master branch from upstream/master
echo "Step 3: Creating local-master branch from upstream/master..."
if git show-ref --quiet refs/heads/local-master; then
    echo "✓ local-master branch already exists"
else
    git branch local-master upstream/master
    echo "✓ local-master branch created"
fi
echo ""

# Step 4: Create local-fork branch (if needed)
echo "Step 4: Creating local-fork branch..."
if git show-ref --quiet refs/heads/local-fork; then
    echo "✓ local-fork branch already exists"
else
    git branch local-fork
    echo "✓ local-fork branch created"
fi
echo ""

# Step 5: Checkout local-master
echo "Step 5: Checking out local-master branch..."
git checkout local-master
echo "✓ Checked out local-master"
echo ""

# Step 6: Show available commits from local-fork
echo "Step 6: Commits available in local-fork for cherry-picking:"
git log local-fork --oneline -5
echo ""

# Step 7: Instructions for cherry-picking
echo "=== Cherry-Pick Instructions ==="
echo ""
echo "To cherry-pick a commit from local-fork to local-master:"
echo "1. Ensure you are on local-master branch: git checkout local-master"
echo "2. Identify the commit hash from local-fork: git log local-fork --oneline"
echo "3. Cherry-pick the commit: git cherry-pick <commit-hash>"
echo ""
echo "Example:"
echo "  git cherry-pick 6728979"
echo ""
echo "=== Current Status ==="
git branch -vv
echo ""
echo "✓ Setup complete!"
