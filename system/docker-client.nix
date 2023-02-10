{ pkgs, ... }: {

  environment.systemPackages = [
    pkgs.docker-client
  ];

  environment.variables = {
    DOCKER_HOST = "ssh://nixos-vm";
  };

}
