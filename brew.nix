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
  ];
}
