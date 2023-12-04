#!/bin/bash

set -x
REMOTE_NAME="profusion"
PLUGIN_BRANCH="fix/hmac"
REMOTE_NAME2="origin"
PLUGIN_BRANCH2="create-plugin"
CUSTOM_KONG_BRANCH="mgc-kong-plugin"
CUSTOM_KONG_PLUGIN_DIR="mgc-kong-plugins"

# update kong plugin branch
cd mgc-kong-plugins
git fetch --all
git switch main
git branch -D $PLUGIN_BRANCH
git switch -c $PLUGIN_BRANCH $REMOTE_NAME/$PLUGIN_BRANCH
# git pull --rebase -X theirs $REMOTE_NAME "$PLUGIN_BRANCH"
git show --oneline
git push -f $REMOTE_NAME2 $PLUGIN_BRANCH2
cd ..

# update kong submodule
cd kong
git switch $CUSTOM_KONG_BRANCH

cd $CUSTOM_KONG_PLUGIN_DIR
git fetch --all
git switch -c temp
git branch -D $PLUGIN_BRANCH2
git switch -c $PLUGIN_BRANCH2 $REMOTE_NAME2/$PLUGIN_BRANCH2
git branch -D temp
#git reset --hard "$REMOTE_NAME2/$PLUGIN_BRANCH2"
cd ..
git add $CUSTOM_KONG_BRANCH
git commit --amend --no-edit
git push -f
cd ..
