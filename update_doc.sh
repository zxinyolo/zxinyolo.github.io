#!/bin/bash


hexo_output=$(hexo g)
wait
echo "$hexo_output"

git_add=$(git add .)
wait
echo "$git_add"

git_commit=$(git ci "new")
wait
echo "$git_commit"

git_push=$(git push origin main)
wait
echo "$git_push"
