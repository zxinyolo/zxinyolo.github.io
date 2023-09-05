#!/bin/bash


hexo_output=$(hexo g)
wait
echo "$hexo_output"
echo "##################### hexo g 完成#######################"

git_add=$(git add .)
wait
echo "$git_add"
echo "##################### git add 完成#####################"

git_commit=$(git ci "new")
wait
echo "$git_commit"
echo "##################### git commit 完成##################"

git_push=$(git push origin main)
wait
echo "$git_push"
