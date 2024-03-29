# skhd help:
# readme: https://github.com/koekeishiya/skhd/blob/master/README.md
# sample config: https://github.com/koekeishiya/skhd/blob/master/examples/skhdrc
# modifier and keywords: https://github.com/koekeishiya/skhd/issues/1
{pkgs, ...}: let
  space-rename = pkgs.writeShellScript "space-rename.sh" ./scripts/space-rename.sh;
  mod = "ctrl";
  yabai = "${pkgs.yabai}/bin/yabai";
  kitty = "${pkgs.kitty}/bin/kitty";
in ''
  ${mod} - down : ${yabai} -m window --focus south || ${yabai} -m window --focus stack.prev || ${yabai} -m window --focus stack.last
  ${mod} - left : ${yabai} -m window --focus west
  ${mod} - right : ${yabai} -m window --focus east
  ${mod} - up : ${yabai} -m window --focus north || ${yabai} -m window --focus stack.next || ${yabai} -m window --focus stack.first

  ${mod} + shift - down : ${yabai} -m window --warp south
  ${mod} + shift - left : ${yabai} -m window --warp west
  ${mod} + shift - right : ${yabai} -m window --warp east
  ${mod} + shift - up : ${yabai} -m window --warp north

  ${mod} + cmd - down : ${yabai} -m window --insert south
  ${mod} + cmd - left : ${yabai} -m window --insert west
  ${mod} + cmd - right : ${yabai} -m window --insert east
  ${mod} + cmd - up : ${yabai} -m window --insert north

  ${mod} - 0x18 : ${yabai} -m space --balance
  ${mod} - m : ${yabai} -m window --toggle zoom-fullscreen
  ${mod} - f : ${yabai} -m window --toggle float

  ${mod} + shift - f : ${yabai} -m space --layout float
  ${mod} + shift - s : ${yabai} -m space --layout stack
  ${mod} + shift - b : ${yabai} -m space --layout bsp

  ctrl + shift - 1 : ${yabai} -m window --space 1
  ctrl + shift - 2 : ${yabai} -m window --space 2
  ctrl + shift - 3 : ${yabai} -m window --space 3
  ctrl + shift - 4 : ${yabai} -m window --space 4
  ctrl + shift - 5 : ${yabai} -m window --space 5

  ${mod} - t : ${kitty} @ --to unix:/tmp/kitty.sock launch --type=os-window --cwd=current || open -a Kitty
  ${mod} - s : osascript -e 'tell application "Safari" to make new document activate'
  ${mod} - q : osascript -e 'tell app "QuickTime Player" to activate' -e 'tell app "QuickTime Player" to present new movie recording'

  ${mod} - 0x2B : ${space-rename}
''
