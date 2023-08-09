{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.yabai = {
    enable = lib.mkEnableOption "Enable yabai window manager";
  };

  config = lib.mkIf config.hxy.yabai.enable {
    # Setup yabai
    services.yabai = {
      enable = true;
      config = let
        gaps = 20;
      in {
        focus_follows_mouse = "autofocus";
        layout = "bsp";
        top_padding = gaps;
        bottom_padding = gaps;
        left_padding = gaps;
        right_padding = gaps;
        window_gap = gaps;
      };
    };

    # Set up the hotkey daemon.
    # Due to https://github.com/NixOS/nixpkgs/issues/246740, we currently use
    # skhd from homebrew. Once fixed, we'll use nix-darwin's `services.skhd`...
    homebrew = {
      taps = ["koekeishiya/formulae"];
      brews = ["skhd"];
    };
    home-manager.users.${config.hxy.base.mainUser}.home.file.".config/skhd/skhdrc" = {
      onChange = "/opt/homebrew/bin/skhd --restart-service";
      text = let
        mod = "ctrl + alt + cmd";
        yabai = "${pkgs.yabai}/bin/yabai";
      in ''
        ${mod} - down : ${yabai} -m window --focus south
        ${mod} - left : ${yabai} -m window --focus west
        ${mod} - right : ${yabai} -m window --focus east
        ${mod} - up : ${yabai} -m window --focus north

        ${mod} + shift - down : ${yabai} -m window --swap south
        ${mod} + shift - left : ${yabai} -m window --swap west
        ${mod} + shift - right : ${yabai} -m window --swap east
        ${mod} + shift - up : ${yabai} -m window --swap north

        ${mod} - 0x18 : ${yabai} -m space --balance
        ${mod} - f : ${yabai} -m window --toggle zoom-fullscreen
        ${mod} - t : ${yabai} -m window --toggle float --grid 4:4:1:1:2:2
      '';
    };
  };
}
