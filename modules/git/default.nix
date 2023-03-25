{
  config,
  lib,
  mainUser,
  ...
}: {
  options.hxy.git.enable = lib.mkEnableOption "Enable git configuration";

  config = lib.mkIf config.hxy.git.enable {
    home-manager.users.${mainUser}.programs.git = {
      enable = true;
      extraConfig = {
        push.autoSetupRemote = true;
      };
      delta = {
        enable = true;
      };
      ignores = [
        ".DS_Store"
        ".direnv"
      ];
    };
  };
}
