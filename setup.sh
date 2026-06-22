#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <dockerHubUsername>"
	exit 1
fi

username="$1"

# Avoid touching the .git directory
find . -type f ! -path './.git/*' -print0 | while IFS= read -r -d '' file; do
	# Use a delimiter that is unlikely to appear in usernames
	if sed --version >/dev/null 2>&1; then
		# GNU sed
		sed -i "s|kamalkhadka|$username|g" "$file"
	else
		# BSD (macOS) sed: -i requires a suffix argument (empty string means no backup)
		sed -i '' "s|kamalkhadka|$username|g" "$file"
	fi
done

echo "Replaced 'kamalkhadka' with '$username' in repository files."
