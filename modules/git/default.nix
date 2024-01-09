{
  config,
  lib,
  pkgs,
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
      default = "dom@domhay.com";
      description = "Default user email to use.";
    };
  };

  config = {
    environment.systemPackages = [
      pkgs.gitMinimal
      pkgs.git-open
    ];
    home-manager.users.${config.hxy.base.mainUser}.programs.git = lib.mkIf config.hxy.git.enable {
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
