set -x
export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin

searchString="$1"
tabId=$(chrome-cli list links | grep -im1 "$searchString" | sed -E 's/^\[([0-9]+)\].*$/\1/')

if test -n "$tabId"; then
	chrome-cli activate -t "$tabId"
else
	chrome-cli open "https://$searchString"
fi
