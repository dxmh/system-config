{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cloudfoundry-cli
    mysql
  ];

  homebrew.taps = [
    "1password/tap"
  ];

  homebrew.casks = [
    "1password"
    "1password-cli"
    "caffeine"
    "clickup"
    "docker"
    "hazeover"
    "numi"
  ];

  home-manager.users.${config.hxy.base.mainUser}.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions.UseKeychain = "yes";
        identitiesOnly = true;
      };
    };
  };

  hxy.base = {
    enable = true;
    mainUser = "dom.hay";
    stateVersion = {
      home-manager = "22.11";
      nix-darwin = 4;
    };
  };

  hxy.aws-tools.enable = true;
  hxy.helix.enable = true;
  hxy.git = {
    enable = true;
    userName = "Dom H";
    userEmail = "dom.hay@cyber-duck.co.uk";
  };
  hxy.window-management = {
    space-icons = "[1]=􀟛 [2]=􀌨 [3]=􀐫 [4]=􀩼 [5]=􀩼 [6]=􀩼 [7]=􀩼 [8]=􀩼 [9]=􀩼 ";
    calendars = "D3EDB5CA-0EA4-45EA-A902-7DCB7072C301";
  };
}
