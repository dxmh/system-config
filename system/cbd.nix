{
  imports = [
    ./darwin.nix
    ../home/aws.nix
  ];

  homebrew.casks = [
    "aws-console"
    "docker"
  ];
}
