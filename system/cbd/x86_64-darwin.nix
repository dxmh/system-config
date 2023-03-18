{
  imports = [
    ../common
    ../../home/aws.nix
    ../../home/sops.nix
  ];

  homebrew.casks = [
    "caffeine"
    "docker"
  ];
}
