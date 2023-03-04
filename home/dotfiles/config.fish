# Disable welcome message
set fish_greeting

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
  echo (basename (prompt_pwd))
end
