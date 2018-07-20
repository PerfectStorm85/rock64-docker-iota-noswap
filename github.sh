#!/bin/bash
read -p 'Changelist name: ' answer
git init
git add .
git commit -m "$answer"
git remote add noswap https://github.com/PerfectStorm85/rock64-docker-iota-noswap.git
git remote -v
git push -u noswap master
