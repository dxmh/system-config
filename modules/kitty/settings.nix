{
  pkgs,
  lib,
  config,
  ...
}: let
  tab_bg = "#e7eaed";
in {
  action_alias = "showhints kitten hints --hints-offset 0 --alphabet tnseriaoplfuwydhcx --hints-background-color black --hints-foreground-color white --hints-text-color blue";
  active_border_color = tab_bg;
  active_tab_background = tab_bg;
  active_tab_foreground = "#5c6166";
  active_tab_font_style = "normal";
  confirm_os_window_close = "-1";
  draw_minimal_borders = "yes";
  enable_audio_bell = false;
  enabled_layouts = "splits, stack";
  inactive_border_color = tab_bg;
  inactive_tab_background = tab_bg;
  inactive_tab_foreground = "#828c9a";
  macos_option_as_alt = true;
  macos_quit_when_last_window_closed = false;
  macos_show_window_title_in = "window";
  macos_titlebar_color = "light";
  mouse_map = "right press ungrabbed mouse_select_command_output";
  placement_strategy = "top-left";
  remote_kitty = "no";
  scrollback_lines = 5000;
  scrollback_pager_history_size = 500;
  selection_foreground = "none";
  selection_background = "#d8d8d7";
  shell = lib.mkIf config.hxy.fish.enable "${pkgs.fish}/bin/fish";
  # Disable automatic shell integration to configure manualy in fish.config:
  shell_integration = lib.mkIf config.hxy.fish.enable "disabled";
  show_hyperlink_targets = "yes";
  startup_session = "session"; # Filename relative to kitty config dir
  tab_bar_align = "left";
  tab_bar_background = tab_bg;
  tab_bar_edge = "bottom";
  tab_bar_margin_color = tab_bg;
  tab_bar_margin_height = "6 4";
  tab_bar_margin_width = 14;
  tab_bar_min_tabs = 2;
  tab_bar_style = "separator";
  tab_separator = "\"  \""; # Two blank spaces
  tab_title_template = ''
    {index}{layout_name.replace('stack', 'ᐩ').replace('splits', '╱')}{title}
  '';
  url_color = "#0087BD";
  url_excluded_characters = "↩";
  window_border_width = "0.5pt";
  window_padding_width = "14 15";
}
