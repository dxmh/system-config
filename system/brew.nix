{ lib, isWork, ... }:

{
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
  };

  homebrew.brews = [
    "aws-console" # https://github.com/aws/aws-cli/issues/4642#issuecomment-768266541
  ];

  homebrew.taps = [
    "homebrew/cask"
  ];

  homebrew.casks = [
    "hammerspoon"
    "raycast"
    "rectangle"
    "mouse-fix"
  ] ++ lib.optionals (!isWork) [
    "discord"
    "element"
    "google-chrome"
    "lulu"
    "signal"
    "slack"
    "syncthing"
    "zoom"
  ] ++ lib.optionals isWork [
    "docker"
  ];
}
