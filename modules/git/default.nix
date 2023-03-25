{
  config,
  lib,
  mainUser,
  ...
}: {
  options.hxy.git = {
    enable = lib.mkEnableOption "Enable git configuration";
    userName = lib.mkOption {
      type = lib.types.str;
      default = "Dom H";
      description = "Default user name to use.";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "dom@hxy.io";
      description = "Default user email to use.";
    };
  };

  config = lib.mkIf config.hxy.git.enable {
    home-manager.users.${mainUser}.programs.git = {
      enable = true;
      extraConfig = {
        push.autoSetupRemote = true;
        user.name = config.hxy.git.userName;
        user.email = config.hxy.git.userEmail;
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
