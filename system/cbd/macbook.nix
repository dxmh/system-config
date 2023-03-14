{
  imports = [
    ../common
    ../../home/aws.nix
  ];

  homebrew.casks = [
    "caffeine"
    "docker"
  ];
}
