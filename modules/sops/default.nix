{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.sops-tools.enable = lib.mkEnableOption "Enable tools for working with sops";
  config = lib.mkIf config.hxy.sops-tools.enable {
    home-manager.users.${config.hxy.base.mainUser} = {
      home.packages = [
        pkgs.age
        pkgs.sops
      ];
      home.sessionVariables = {
        SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
      };
      # https://github.com/mozilla/sops#47showing-diffs-in-cleartext-in-git
      programs.git.extraConfig = {
        diff.sopsdiffer = {
          textconv = "${pkgs.sops}/bin/sops --config /dev/null -d";
        };
      };
    };
  };
}
