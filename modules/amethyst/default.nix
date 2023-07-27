{
  config,
  lib,
  ...
}: {
  options.hxy.amethyst = {
    enable = lib.mkEnableOption "Enable Amethyst window manager";
    config = lib.mkOption {
      type = lib.types.attrs;
      description = "Configuration options for ~/.amethyst.yml";
      default = {
        mod1 = [
          "control"
          "option"
          "command"
        ];
        mod2 = [
          "shift"
          "control"
          "option"
          "command"
        ];
        layouts = [
          "two-pane"
          "fullscreen"
          "tall"
        ];
        shrink-main = {
          mod = "mod2";
          key = "left";
        };
        expand-main = {
          mod = "mod2";
          key = "right";
        };
        focus-ccw = {
          mod = "mod1";
          key = "up";
        };
        focus-cw = {
          mod = "mod1";
          key = "down";
        };
        focus-main = {
          mod = "mod1";
          key = "left";
        };
        swap-ccw = {
          mod = "mod2";
          key = "up";
        };
        swap-cw = {
          mod = "mod2";
          key = "down";
        };
        swap-main = {
          mod = "mod1";
          key = "enter";
        };
        select-fullscreen-layout = {
          mod = "mod1";
          key = "1";
        };
        select-tall-layout = {
          mod = "mod1";
          key = "3";
        };
        select-two-pane-layout = {
          mod = "mod1";
          key = "2";
        };
        relaunch-amethyst = {
          mod = "mod1";
          key = "escape";
        };
        window-margins = true;
        window-margin-size = 30;
        mouse-follows-focus = true;
        mouse-swaps-windows = true;
        mouse-resizes-windows = true;
        floating = [
          "com.apple.systempreferences"
          # Ideally only the "ClickUp Command Bar" window would float,
          # see https://github.com/ianyh/Amethyst/issues/1334
          "com.clickup.desktop-app"
          "com.raycast.macos"
        ];
      };
    };
  };

  config = lib.mkIf config.hxy.amethyst.enable {
    # Install the application:
    homebrew.casks = ["amethyst"];

    # Build the configuration file:
    # Docs: https://github.com/ianyh/Amethyst/blob/development/docs/configuration-files.md
    # Sample: https://github.com/ianyh/Amethyst/blob/development/.amethyst.sample.yml
    home-manager.users.${config.hxy.base.mainUser} = {
      home.file.amethyst = {
        target = ".amethyst.yml";
        onChange = "/usr/bin/pkill Amethyst; /usr/bin/open -a Amethyst";
        text = builtins.toJSON config.hxy.amethyst.config;
      };
    };
  };
}
