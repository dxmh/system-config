{...}: {
  homebrew.casks = [
    "caffeine"
  ];

  hxy.base = {
    enable = true;
    mainUser = "dom.hay";
    stateVersion = {
      home-manager = "22.11";
      nix-darwin = 4;
    };
  };
}
