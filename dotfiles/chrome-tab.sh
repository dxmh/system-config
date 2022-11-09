set -x

chromeCli="/usr/local/bin/chrome-cli"
searchString="$1"
tabId=$($chromeCli list links | grep -im1 "$searchString" | sed -E 's/^\[([0-9]+)\].*$/\1/')

if test -n "$tabId"; then
	$chromeCli activate -t "$tabId"
else
	$chromeCli open "https://$searchString"
fi
