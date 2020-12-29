#!/bin/bash
# Based on https://github.com/ejuarezg/containers/blob/master/iosevka_font/run.sh

set -e

cd *Iosevka-*

echo "Building version ${FONT_VERSION}"

npm install

if ! test -f "./private-build-plans.toml"; then
	echo "No private-build-plans.toml found. Proceeding with the standard build"
else
	echo "Using the provided build-plans file.."
	# No arguments passed
	if [ $# -eq 0 ]; then
    		# Get the name of the first build plan when the user does not provide
    		# custom build arguments (automatic mode)
    		PLAN_NAME=$(grep -Po -m 1 '(?<=buildPlans.)[^\]]*' private-build-plans.toml)

    		npm run build -- contents::$PLAN_NAME
	else
    		# User knows what they are doing and provided custom build arguments
    		# (manual mode)
    		npm run build -- "$@"
	fi
fi
