{
  homebrew.casks = [
    "caffeine"
    "docker"
  ];

  hxy.base.enable = true;
  hxy.base.flakeUri = "/share/";
  hxy.base.mainUser = "dom.hay";

  hxy.git.enable = true;
  hxy.helix.enable = true;
  hxy.sops-tools.enable = true;
}
