{
  "cmd+t" = "launch --type=tab";
  "cmd+shift+t" = "launch --cwd=current --type=tab --location=neighbor";
  "cmd+shift+n" = "new_os_window_with_cwd";
  "cmd+enter" = "combine : goto_layout splits : launch --cwd=current --location=split";
  "cmd+shift+enter" = "launch --location=split";
  "cmd+c" = "copy_and_clear_or_interrupt";
  "cmd+alt+f" = "toggle_layout stack";
  "cmd+alt+r" = "layout_action rotate";
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
  "cmd+alt+p" = "showhints --type path --program -";

  "cmd+z" = "send_text all \\x1bz"; # alt+z, used for undo
  "cmd+shift+z" = "send_text all \\x1bZ"; # alt+shift+z, used for redo

  # remap frequent ctrl+keys to cmd
  # use `kitty +kitten show_key` to find `send_text` value
  "cmd+d" = "send_text all \\x04";
  "cmd+f" = "send_text all \\x06";
  "cmd+l" = "send_text all \\x0c";
  "cmd+n" = "send_text all \\x0e";
  "cmd+p" = "send_text all \\x10";
  "cmd+r" = "send_text all \\x12";
}
