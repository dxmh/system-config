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
