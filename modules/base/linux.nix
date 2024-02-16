{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.hxy.base.enable {
    boot.loader = {
      timeout = 1;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 5; # Prevent infinite generations filling up /boot
      };
    };

    nix.gc.dates = "weekly";
    nix.settings.auto-optimise-store = true;

    # Allow these users to specify additional binary caches
    nix.settings.trusted-users = ["@wheel"];

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    system.autoUpgrade = {
      enable = true;
      allowReboot = false;
      flake = config.hxy.base.flakeUri;
    };

    system.stateVersion = config.hxy.base.stateVersion.nixos;

    time.timeZone = "Europe/London";

    users.users.${config.hxy.base.mainUser} = {
      isNormalUser = true;
      initialPassword = "hunter2";
      extraGroups = ["wheel"];
      shell = lib.mkIf config.hxy.fish.enable pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpIMrPStsNADURgP6ZXp+1PwMrIMOthUwVLWdP11XBd"
      ];
    };
  };
}
