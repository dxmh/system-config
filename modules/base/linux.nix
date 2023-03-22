{
  config,
  lib,
  mainUser,
  pkgs,
  ...
}: {
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
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "github:dxmh/system-config";
  };

  time.timeZone = "Europe/London";

  users.users.${mainUser} = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = ["wheel"];
    shell = lib.mkIf config.hxy.fish.enable pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpIMrPStsNADURgP6ZXp+1PwMrIMOthUwVLWdP11XBd"
    ];
  };
}
