#!/usr/bin/env bash

echo "Running prepare-commit-msg hook"

# Get the staged diff
DIFF=$(git diff)

# Generate a summary with ollama CLI and phi4 model

SUMMARY=$(
  ollama run llama3.2:3b <<EOF
Generate a raw text commit message for the following diff.
Keep commit message concise and to the point.
Make the first line the title (100 characters max) and the rest the body:
$DIFF
EOF
)

echo $SUMMARY