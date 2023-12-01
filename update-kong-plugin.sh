#!/bin/bash

set -x
PLUGIN_BRANCH="no-trust-cid"
CUSTOM_KONG_BRANCH="mgc-kong-plugin"

# update kong plugin branch
cd mgc-kong-plugins
git fetch
git switch $PLUGIN_BRANCH
git pull --rebase -X theirs origin "$PLUGIN_BRANCH"
git show --oneline
git push -f gitlab HEAD
cd ..

# update kong submodule
cd kong
git switch $CUSTOM_KONG_BRANCH

cd $CUSTOM_KONG_BRANCH
git switch $PLUGIN_BRANCH
git fetch --all
git reset --hard "origin/$PLUGIN_BRANCH"
cd ..
git add $CUSTOM_KONG_BRANCH
git commit --amend --no-edit
git push -f
cd ..
