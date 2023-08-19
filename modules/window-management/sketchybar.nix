{pkgs, ...}: {
  enable = true;
  config = builtins.readFile ./scripts/sketchybarrc.sh;
  extraPackages = with pkgs; [
    jq
    (writeShellScriptBin "calendar.sh" ./scripts/calendar.sh)
    (writeShellScriptBin "mail.sh" ./scripts/mail.sh)
    (writeShellScriptBin "slack.sh" ./scripts/slack.sh)
    (writeShellScriptBin "space.sh" ./scripts/space.sh)
    (writeShellScriptBin "space-click.sh" ./scripts/space-click.sh)
    (writeShellScriptBin "yabai-app-name.sh" ./scripts/yabai-app-name.sh)
    (writeShellScriptBin "yabai-layout-click.sh" ./scripts/yabai-layout-click.sh)
    (writeShellScriptBin "yabai-layout.sh" ./scripts/yabai-layout.sh)
    (writeShellScriptBin "yabai-window-title.sh" ./scripts/yabai-window-title.sh)
  ];
}
