#!/bin/bash

Write-Output -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
$msg="rebuilding site"
If ($args.Count -eq 1) {
    $msg=$args[0]
}
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
Set-Location ..