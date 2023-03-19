# Home Manager configuration for Kitty terminal
{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = [
      "--title='kitty'"
    ];
    keybindings = {
      # Run `kitty +kitten show_key` to get key info
      "cmd+t" = "launch --type=tab";
      "cmd+shift+t" = "launch --cwd=current --type=tab --location=neighbor";
      "cmd+shift+n" = "new_os_window_with_cwd";
      "cmd+enter" = "combine : goto_layout splits : launch --cwd=current --location=split";
      "cmd+shift+enter" = "launch --location=split";
      "cmd+c" = "copy_and_clear_or_interrupt";
      "cmd+f" = "toggle_layout stack";
      "cmd+r" = "layout_action rotate";
      "cmd+w" = "close_window";
      "cmd+alt+w" = "close_other_windows_in_tab";
      "cmd+up" = "previous_window";
      "cmd+down" = "next_window";
      "cmd+k" = "previous_window";
      "cmd+j" = "next_window";
      "cmd+shift+r" = "start_resizing_window";
      "cmd+shift+up" = "move_window up";
      "cmd+shift+down" = "move_window down";
      "cmd+shift+left" = "move_window left";
      "cmd+shift+right" = "move_window right";
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";
      "cmd+]" = "next_tab";
      "cmd+[" = "previous_tab";
      "cmd+shift+]" = "move_tab_forward";
      "cmd+shift+[" = "move_tab_backward";
      "cmd+," = "set_tab_title";
      "cmd+equal" = "change_font_size all +1.0";
      "cmd+minus" = "change_font_size all -1.0";
      "cmd+plus" = "change_font_size all +1.0";
      "alt+backspace" = "send_text all \\x17";
      "alt+delete" = "send_text all \\x1B\\x64";
      "alt+left" = "send_text all \\x1B\\x62";
      "alt+right" = "send_text all \\x1B\\x66";
      "cmd+backspace" = "send_text all \\x15";
      "cmd+delete" = "send_text all \\x0b";
      "cmd+left" = "send_text all \\x1bOH";
      "cmd+right" = "send_text all \\x1bOF";
      "alt+cmd+down" = "scroll_to_prompt 1";
      "alt+cmd+up" = "scroll_to_prompt -1";
      "cmd+shift+g" = "show_last_command_output";
      "cmd+shift+h" = "show_scrollback";
      "alt+up" = "kitten smart_scroll.py scroll_page_up ctrl+u";
      "alt+down" = "kitten smart_scroll.py scroll_page_down ctrl+d";
      "cmd+u" = "showhints --type url";
      "cmd+p" = "showhints --type path --program -";
    };
    settings = {
      action_alias = "showhints kitten hints --hints-offset 0 --alphabet tnseriaoplfuwydhcx --hints-background-color black --hints-foreground-color white --hints-text-color blue";
      active_border_color = "#5c6370";
      active_tab_background = "#181825";
      active_tab_font_style = "normal";
      active_tab_foreground = "#CDD6F4";
      confirm_os_window_close = "-1";
      draw_minimal_borders = "yes";
      enable_audio_bell = false;
      enabled_layouts = "splits, stack";
      font_family = "Iosevka";
      font_size = 16;
      hide_window_decorations = "titlebar-only";
      inactive_border_color = "#313640";
      inactive_tab_background = "#181825";
      inactive_tab_foreground = "#7F849C";
      inactive_text_alpha = "0.65";
      macos_option_as_alt = true;
      macos_quit_when_last_window_closed = false;
      macos_show_window_title_in = "window";
      macos_thicken_font = "0.5";
      macos_titlebar_color = "background";
      modify_font = "cell_height 5px";
      mouse_map = "right press ungrabbed mouse_select_command_output";
      placement_strategy = "top-left";
      remote_kitty = "no";
      scrollback_lines = 5000;
      scrollback_pager_history_size = 500;
      shell = "${pkgs.fish}/bin/fish";
      shell_integration = "disabled"; # Configured manually via fish.config
      startup_session = "session"; # filename relative to kitty config dir
      tab_bar_align = "left";
      tab_bar_background = "#181825";
      tab_bar_edge = "bottom";
      tab_bar_margin_color = "#181825";
      tab_bar_margin_height = "3 3";
      tab_bar_margin_width = 14;
      tab_bar_min_tabs = 1;
      tab_bar_style = "separator";
      tab_separator = "\"  \""; # two blank spaces
      tab_title_template = ''
        {index}{layout_name.replace('stack', 'ᐩ').replace('splits', '╱')}{title}
      '';
      url_color = "#0087BD";
      window_border_width = "0.5pt";
      window_padding_width = "14 15";
    };
    theme = "Catppuccin-Mocha";
  };

  home.activation = {
    reloadKittyConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      killall -SIGUSR1 kitty || true
    '';
  };

  home.file.".config/kitty/smart_scroll.py" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/yurikhan/kitty-smart-scroll/8aaa91/smart_scroll.py";
      sha256 = "sha256:0p6x51gf4m2r61w894cvzhy6cmvzmadz0jbvvj0clcvq1vh9kc63";
    };
  };

  # When `$SSH_ASKPASS` is unset, kitty's askpass implementation breaks...
  home.sessionVariables.SSH_ASKPASS = "false";
}
