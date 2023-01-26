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
abbr gs "git status --short --untracked-files --branch"

abbr add "git add"
abbr fetch "git fetch --all"
abbr pull "git pull"
abbr push "git push"
abbr stash "git stash"
abbr show "git show"
abbr log "git log"
abbr co "git checkout"
abbr c "git commit -vp"

abbr "-" "cd -"
abbr "." "cd -"
abbr ".." "cd ../"
abbr "..." "cd ../../"

abbr cat "bat"
abbr vim "hx"

# Theme
# name: 'Catppuccin mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 1e1e2e
set fish_color_normal cdd6f4
set fish_color_command 89b4fa
set fish_color_param f2cdcd
set fish_color_keyword f38ba8
set fish_color_quote a6e3a1
set fish_color_redirection f5c2e7
set fish_color_end fab387
set fish_color_error f38ba8
set fish_color_gray 6c7086
set fish_color_selection --background=313244
set fish_color_search_match --background=313244
set fish_color_operator f5c2e7
set fish_color_escape f2cdcd
set fish_color_autosuggestion 6c7086
set fish_color_cancel f38ba8
set fish_color_cwd f9e2af
set fish_color_user 94e2d5
set fish_color_host 89b4fa
set fish_pager_color_progress 6c7086
set fish_pager_color_prefix f5c2e7
set fish_pager_color_completion cdd6f4
set fish_pager_color_description 6c7086
