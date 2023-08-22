{pkgs, ...}: let
  space-rename = pkgs.writeShellScript "space-rename.sh" ./scripts/space-rename.sh;
  mod = "ctrl + alt + cmd";
  yabai = "${pkgs.yabai}/bin/yabai";
  kitty = "${pkgs.kitty}/bin/kitty";
in ''
  ${mod} - down : ${yabai} -m window --focus south || ${yabai} -m window --focus stack.prev
  ${mod} - left : ${yabai} -m window --focus west
  ${mod} - right : ${yabai} -m window --focus east
  ${mod} - up : ${yabai} -m window --focus north || ${yabai} -m window --focus stack.next

  ${mod} + shift - down : ${yabai} -m window --swap south
  ${mod} + shift - left : ${yabai} -m window --swap west
  ${mod} + shift - right : ${yabai} -m window --swap east
  ${mod} + shift - up : ${yabai} -m window --swap north

  ${mod} - 0x18 : ${yabai} -m space --balance
  ${mod} - f : ${yabai} -m window --toggle zoom-fullscreen
  ${mod} - return : ${yabai} -m window --toggle zoom-fullscreen

  ${mod} - 0 : ${yabai} -m space --layout float
  ${mod} - 1 : ${yabai} -m space --layout stack
  ${mod} - 2 : ${yabai} -m space --layout bsp

  ctrl + shift - 1 : ${yabai} -m window --space 1
  ctrl + shift - 2 : ${yabai} -m window --space 2
  ctrl + shift - 3 : ${yabai} -m window --space 3
  ctrl + shift - 4 : ${yabai} -m window --space 4
  ctrl + shift - 5 : ${yabai} -m window --space 5

  ${mod} - t : ${kitty} @ --to unix:/tmp/kitty.sock launch --type=os-window --cwd=current || open -a Kitty
  ${mod} - w : osascript -e 'tell application "Safari" to make new document activate'

  ${mod} - 0x2B : ${space-rename}
''
