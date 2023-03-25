{
  homebrew.casks = [
    "caffeine"
    "docker"
  ];

  hxy.base = {
    enable = true;
    flakeUri = "/share/";
    mainUser = "dom.hay";
    stateVersion = {
      home-manager = "22.05";
      nix-darwin = 4;
    };
  };

  hxy.git.enable = true;
  hxy.helix.enable = true;
  hxy.sops-tools.enable = true;
}
