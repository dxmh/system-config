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
  ] ++ lib.optionals (!isWork) [
    "google-chrome"
    "signal"
    "zoom"
  ] ++ lib.optionals isWork [
    "docker"
    "rectangle"
  ];
}
