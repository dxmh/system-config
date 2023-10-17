#!/bin/bash
# Small wrapper around the `aws-console` command

filter=${1:-""}

# Choose an AWS profile
profile=$(sed -nE "s/\[profile (.+)\]/\1/p" ~/.aws/config | fzf -e -1 -q "$filter")

# Abort if no profile selected
test -z "$profile" && exit 2

# Generate the login URL
login_url="$(aws-console --url --profile "$profile")"

# URL to log out of existing sessions
logout_url="https://signin.aws.amazon.com/oauth?Action=logout"

# Logout of current account and then log in with desired account
osascript -e "
  tell application \"Safari\"
    tell window 1
      set current tab to (make new tab with properties {URL:\"$logout_url\"})
      delay 1
      tell current tab to set URL to \"$login_url\"
    end tell
  end tell
"
