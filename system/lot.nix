{pkgs, ...}: {
  imports = [./darwin.nix];

  environment = {
    systemPackages = [
      pkgs.docker-client
    ];
    variables = {
      DOCKER_HOST = "ssh://nixos-vm";
    };
  };

  homebrew.casks = [
    "discord"
    "element"
    "google-chrome"
    "parallels"
    "signal"
    "slack"
    "syncthing"
    "utm"
    "zoom"
  ];
}
