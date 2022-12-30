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

  home.file.".config/kitty/themes/mocha.conf" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/kitty/37a9bcac429cdd04c0ecb4041ce6c6e3d4b53f42/mocha.conf";
      sha256 = "sha256:1mk9y8mcrq4yzlfw9jn8j80mm2djzrihglvp71vl0513fdyf8gb1";
    };
  };

}
