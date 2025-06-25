#!/bin/bash

# Configuration
author_name="Edric Oswin"
author_email="edricoswin3@gmail.com"
file_list="file_list.txt"
total_days=25              # Number of active days within the last 30
max_commits_per_day=3      # Commits per day (1–3)

# Check if file list exists
if [ ! -f "$file_list" ]; then
  echo "❌ file_list.txt not found!"
  exit 1
fi

# Load file paths from file_list.txt
mapfile -t files < "$file_list"

# Sample commit messages
messages=(
  "Fix validation bug"
  "Update README"
  "Improve loading speed"
  "Refactor controller"
  "Adjust layout margins"
  "Optimize function calls"
  "Update test cases"
  "Improve logging"
  "Fix broken route"
  "Minor UI tweaks"
)

echo "🚀 Generating commits across the last 30 days..."

for ((i = 0; i < total_days; i++)); do
  # Pick a random number of days ago (from 0 to 29)
  days_ago=$((RANDOM % 30))
  commit_date=$(date -d "$days_ago days ago" +"%Y-%m-%dT%H:%M:%S")

  # Random commits on that day
  commits_today=$((RANDOM % max_commits_per_day + 1))

  for ((j = 0; j < commits_today; j++)); do
    msg="${messages[$RANDOM % ${#messages[@]}]}"
    file="${files[$RANDOM % ${#files[@]}]}"

    export GIT_AUTHOR_NAME="$author_name"
    export GIT_AUTHOR_EMAIL="$author_email"
    export GIT_COMMITTER_NAME="$author_name"
    export GIT_COMMITTER_EMAIL="$author_email"
    export GIT_AUTHOR_DATE="$commit_date"
    export GIT_COMMITTER_DATE="$commit_date"

    git add "$file" 2>/dev/null
    git commit --allow-empty -m "$msg" > /dev/null
    echo "✅ Commit: $msg on $commit_date using $f_
