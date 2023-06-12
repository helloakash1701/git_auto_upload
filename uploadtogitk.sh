#!/usr/bin/env bash

# Making a script to automatically push your code to your repo

git init

echo "Please enter your GitHub repository URL"
read -r url

echo "$url"

echo "Please confirm your GitHub ID with Y or N"
read -r output

if [ "${output}" == "Y" ]; then
    git remote remove origin
    git remote add origin "$url"
else
    echo "Couldn't find your repository URL"
    exit 1
fi

echo "Do you want to create a new branch? (Y/N)"
read -r createBranch

if [ "${createBranch}" == "Y" ]; then
    echo "Please enter the branch name"
    read -r branchName
    git branch "$branchName"
    git checkout "$branchName"
fi

echo "Adding and committing your files"
git add .
git commit -m "Added your files"

echo "Pushing the changes to the repository"
git push -u origin HEAD

if [ "${createBranch}" == "Y" ]; then
    echo "Do you want to merge the branch into main? (Y/N)"
    read -r mergeBranch

    if [ "${mergeBranch}" == "Y" ]; then
        git checkout main
        git pull origin main --allow-unrelated-histories
        git merge "$branchName"
        git push origin main
        echo "Branch merged successfully into main"
    else
        echo "Branch not merged"
    fi
fi
