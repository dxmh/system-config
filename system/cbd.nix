{
  imports = [
    ./darwin.nix
    ../home/aws.nix
  ];

  homebrew.casks = [
    "docker"
  ];
}
