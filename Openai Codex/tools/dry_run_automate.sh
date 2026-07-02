#!/usr/bin/env bash
set -euo pipefail

# Dry-run wrapper for tools/automate_fix_workflows.sh
# This prints the repos that would be processed and shows the exact commands
# without performing any network or git operations.

REPOS_FILE=${1:-repos.txt}

if [ ! -f "$REPOS_FILE" ]; then
  echo "Repos file not found: $REPOS_FILE" >&2
  exit 2
fi

echo "DRY RUN: will simulate processing repos from $REPOS_FILE"
while IFS= read -r repo || [ -n "$repo" ]; do
  repo_trim=$(echo "$repo" | tr -d '\r' | sed -e 's/^\s*//' -e 's/\s*$//')
  [ -z "$repo_trim" ] && continue
  echo
  echo "Would clone: https://github.com/$repo_trim.git"
  echo "Would run: python3 tools/fix_github_workflows.py . (inside repo)"
  echo "If changes: would create branch 'fix/workflows-permissions', commit, push and open PR via gh"
done < "$REPOS_FILE"

echo
echo "Dry run complete. No changes were made."
