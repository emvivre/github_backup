#!/bin/sh

set -eu

if [ $# -ne 1 ]; then
	echo "Usage: $0 <USER>"
	exit 1
fi

U=$1

curl -s -H 'Accept: application/vnd.github.v3+json' https://api.github.com/users/$U | jq '.id' | grep -q -v null || (echo 'ERROR: User not found !' && exit 1)
curl -s -H 'Accept: application/vnd.github.v3+json' https://api.github.com/users/$U/repos | jq -s '.[][].html_url' | xargs -n1 git clone
