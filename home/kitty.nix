# Home Manager configuration for Kitty terminal

{ pkgs, lib, ... }: {

  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
    };
    darwinLaunchOptions = [
      "--title='kitty'"
    ];
    extraConfig = builtins.readFile ./dotfiles/kitty.conf;
    theme = "One Half Light";
  };

  home.activation = {
    reloadKittyConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      killall -SIGUSR1 kitty || true
    '';
  };

  home.file.".config/kitty/smart_scroll.py" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/yurikhan/kitty-smart-scroll/8aaa91/smart_scroll.py";
      sha256 = "sha256:0p6x51gf4m2r61w894cvzhy6cmvzmadz0jbvvj0clcvq1vh9kc63";
    };
  };

}
