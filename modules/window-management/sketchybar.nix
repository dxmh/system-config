{
  config,
  pkgs,
  ...
}: {
  enable = true;
  config =
    ''
      spaceicons=(${config.hxy.window-management.space-icons})
      calendarUIDs="${config.hxy.window-management.calendars}"
    ''
    + builtins.readFile ./scripts/sketchybarrc.sh;
  extraPackages = with pkgs; [
    jq
    gnugrep
    gnused
    (writeShellScriptBin "calendar.sh" ./scripts/calendar.sh)
    (writeShellScriptBin "calendar-click.sh" ./scripts/calendar-click.sh)
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
