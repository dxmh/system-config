{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cloudfoundry-cli
    mysql
  ];

  homebrew.taps = [
    "1password/tap"
  ];

  homebrew.casks = [
    "1password"
    "1password-cli"
    "caffeine"
    "clickup"
    "docker"
    "hazeover"
    "numi"
  ];

  home-manager.users.${config.hxy.base.mainUser}.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions.UseKeychain = "yes";
        identitiesOnly = true;
      };
    };
  };

  hxy.base = {
    enable = true;
    mainUser = "dom.hay";
    stateVersion = {
      home-manager = "22.11";
      nix-darwin = 4;
    };
  };

  hxy.aws-tools.enable = true;
  hxy.helix.enable = true;
  hxy.git = {
    enable = true;
    userName = "Dom H";
    userEmail = "dom.hay@cyber-duck.co.uk";
  };
}
