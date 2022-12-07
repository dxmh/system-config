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

  homebrew.taps = [
    "homebrew/cask"
  ];

  homebrew.casks = [
    "hammerspoon"
    "rectangle"
    "mouse-fix"
  ] ++ lib.optionals (!isWork) [
    "discord"
    "google-chrome"
    "signal"
    "slack"
    "zoom"
  ] ++ lib.optionals isWork [
    "docker"
  ];
}
