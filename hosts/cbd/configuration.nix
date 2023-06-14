{...}: {
  homebrew.casks = [
    "caffeine"
    "docker"
  ];

  hxy.base = {
    enable = true;
    mainUser = "dom.hay";
    stateVersion = {
      home-manager = "22.11";
      nix-darwin = 4;
    };
  };

  hxy.aws-tools.enable = true;
  hxy.git.enable = true;
  hxy.helix.enable = true;
}
