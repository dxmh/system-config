{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.helix.enable = lib.mkEnableOption "Enable customised helix editor";

  config = lib.mkIf config.hxy.helix.enable {
    environment.variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
    };
    home-manager.users.${config.hxy.base.mainUser} = {
      programs.helix = {
        enable = true;
        settings.theme = "ayu_light";
        settings.editor = import ./editor.nix;
        settings.keys = import ./keys.nix;
        languages = import ./languages.nix {inherit config lib pkgs;};
      };
    };
  };
}
