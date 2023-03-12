{
  pkgs,
  mainUser,
  ...
}: {
  imports = [./common.nix];
  home-manager.extraSpecialArgs = {isDarwin = false;};

  environment.variables = {
    # This doesn't get set automatically on (headless) Linux environments,
    # but it is required for Kitty's awesome shell integration to work:
    # https://sw.kovidgoyal.net/kitty/shell-integration
    KITTY_INSTALLATION_DIR = "${pkgs.kitty}/lib/kitty";
  };

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

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  time.timeZone = "Europe/London";

  users.users.${mainUser} = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = ["wheel"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpIMrPStsNADURgP6ZXp+1PwMrIMOthUwVLWdP11XBd"
    ];
  };
}
