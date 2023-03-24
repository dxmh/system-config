{
  config,
  lib,
  mainUser,
  pkgs,
  ...
}: {
  options.hxy.helix.enable = lib.mkEnableOption "Enable customised helix editor";

  config = lib.mkIf config.hxy.helix.enable {
    environment.variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
    };
    home-manager.users.${mainUser} = {
      programs.helix = {
        enable = true;
        settings.theme = "github_dark";
        settings.editor = import ./editor.nix;
        settings.keys = import ./keys.nix;
        languages = import ./languages.nix {inherit pkgs;};
      };
    };
  };
}
