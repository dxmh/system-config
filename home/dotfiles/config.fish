# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# Kitty shell integration:
if set -q KITTY_INSTALLATION_DIR
  set --global KITTY_SHELL_INTEGRATION enabled
  source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
  set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

# Just show the current directory and command in the title
function fish_title
  echo (basename (prompt_pwd)) $argv | cut -d' ' -f1-2
end

abbr a "aws"
abbr d "docker"
abbr dc "docker-compose"
abbr e "$EDITOR"
abbr l "tree -aFvC -I .git -L 1"
abbr m "make -s"
abbr ns "nix-shell"
abbr psg "ps auxwww | grep -i"
abbr qr "qrencode -t ansi"
abbr c "z"; # z is not pinky-friendly; c is for "cd"
abbr tf "terraform"

abbr kssh "kitty +kitten ssh"
abbr n "kitty +kitten ssh nixos";

abbr "g." "git switch -"
abbr g "git"
abbr gc "git commit -v"
abbr gco "git checkout"
abbr gcp "git commit -v -p"
abbr gd "git diff"
abbr gf "git fetch --all"
abbr gl "git log"
abbr gs "vim +Git +only"
abbr gst "git stash"
abbr pull "git pull"
abbr push "git push"

abbr "-" "cd -"
abbr "." "cd -"
abbr ".." "cd ../"
abbr "..." "cd ../../"

alias cat "bat"
