{ lib, isWork, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.brews = [
    "chrome-cli"
  ];

  homebrew.taps = [
    "homebrew/cask"
  ];

  homebrew.casks = [
    "hammerspoon"
    "rectangle"
  ] ++ lib.optionals (!isWork) [
    "google-chrome"
    "signal"
    "slack"
    "zoom"
  ] ++ lib.optionals isWork [
    "docker"
  ];
}
