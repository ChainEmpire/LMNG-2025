#!/bin/bash

# Config
author_name="Edric Oswin"
author_email="edricoswin3@gmail.com"
file_list="file_list.txt"
total_days=120             # number of different days to commit
max_commits_per_day=3

# Check file list
if [ ! -f "$file_list" ]; then
  echo "❌ $file_list not found!"
  exit 1
fi

# Load file paths into array
mapfile -t files < "$file_list"

# Commit messages
messages=(
  "Refactor module"
  "Fix login issue"
  "Add missing validations"
  "Improve UI responsiveness"
  "Update documentation"
  "Minor bug fixes"
  "Refactor utility functions"
  "Clean up unused imports"
  "Enhance type safety"
  "Optimize rendering performance"
)

echo "🚀 Generating fake commits..."

for ((day=0; day<total_days; day++)); do
  # Pick random day in past 365 days
  days_ago=$((RANDOM % 365))
  commit_date=$(date -d "$days_ago days ago" +"%Y-%m-%dT%H:%M:%S")

  # 1–max commits on this day
  commits_today=$((RANDOM % max_commits_per_day + 1))

  for ((c=0; c<commits_today; c++)); do
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
    echo "✅ Commit: $msg on $commit_date using $file"
  done
done

# Final commit 30–60 days ago to trigger "Updated 2 months ago"
final_days_ago=$((RANDOM % 31 + 30))
final_date=$(date -d "$final_days_ago days ago" +"%Y-%m-%dT%H:%M:%S")

export GIT_AUTHOR_DATE="$final_date"
export GIT_COMMITTER_DATE="$final_date"
git commit --allow-empty -m "Final activity update" > /dev/null

echo "📅 Final commit made on: $final_date"

echo "🎯 Done. Push to GitHub with:"
echo "    git push origin main"
