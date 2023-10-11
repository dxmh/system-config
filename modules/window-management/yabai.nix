{pkgs, ...}: let
  gaps = 35;
  bar_height = "45";
  sketchybar = "${pkgs.sketchybar}/bin/sketchybar";
in {
  enable = true;
  config = {
    focus_follows_mouse = "autofocus";
    layout = "bsp";
    top_padding = gaps;
    bottom_padding = gaps;
    left_padding = gaps;
    right_padding = gaps;
    window_gap = gaps;
    mouse_modifier = "ctrl";
    external_bar = "all:${bar_height}:0";
    active_window_border_color = "0x40000000"; # 30% black
    normal_window_border_color = "0x00ffffff"; # transparent
    window_border = "off";
    window_border_width = "2";
  };
  extraConfig = ''
    yabai -m rule --add app='System Settings' manage=off
    yabai -m rule --add app='QuickTime Player' title='Movie Recording' manage=off
    yabai -m rule --add app='Raycast' manage=off
    yabai -m rule --add app='Things' manage=off
    yabai -m signal --add event=window_focused action="${sketchybar} --trigger yabai_focus_change"
    yabai -m signal --add event=window_title_changed action="${sketchybar} --trigger yabai_title_change"
    yabai -m signal --add event=window_resized action="${sketchybar} --trigger yabai_window_resized"
  '';
}
