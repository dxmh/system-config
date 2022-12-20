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
    "raycast"
    "rectangle"
    "mouse-fix"
  ] ++ lib.optionals (!isWork) [
    "discord"
    "element"
    "google-chrome"
    "signal"
    "slack"
    "zoom"
  ] ++ lib.optionals isWork [
    "docker"
  ];
}
