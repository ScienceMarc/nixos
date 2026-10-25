#!/usr/bin/env bash

# Format all Nix files in the repository using nixfmt
echo "Formatting all Nix files in the repository..."

# Find all .nix files and format them
find . -name "*.nix" -type f -not -path "./.git/*" | while read -r file; do
  if [ -f "$file" ]; then
    echo "Formatting $file..."
    nixfmt "$file"
  fi
done

echo "Formatting complete!"