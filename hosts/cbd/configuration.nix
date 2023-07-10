{config, ...}: {
  homebrew.casks = [
    "bike"
    "caffeine"
    "clickup"
    "docker"
    "dozer"
    "hazeover"
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
  hxy.firefox = {
    enable = true;
    extraAddons = [
      config.nur.repos.rycee.firefox-addons.onepassword-password-manager
    ];
  };
}
