#!/bin/bash
# Small wrapper around the `aws-console` command

filter=${1:-""}

# Choose an AWS profile
profile=$(sed -nE "s/\[profile (.+)\]/\1/p" ~/.aws/config | fzf -e -1 -q "$filter")

# Abort if no profile selected
test -z "$profile" && exit 2

# Generate the login URL
login_url="$(aws-console --url --profile "$profile")"

# Logout of current account and then log in with desired account
open -u "https://signin.aws.amazon.com/oauth?Action=logout"
open -u "$login_url"