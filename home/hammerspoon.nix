# Home Manager configuration for Hammerspoon
{
  home.file.".hammerspoon/init.lua" = {
    source = ./dotfiles/hammerspoon/init.lua;
  };

  home.file.".hammerspoon/hotkeys.lua" = {
    source = ./dotfiles/hammerspoon/hotkeys.lua;
  };

  home.file.".hammerspoon/Spoons/ElgatoKey.spoon/init.lua" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/evantravers/hammerspoon-config/9c38eb/Spoons/ElgatoKey.spoon/init.lua";
      sha256 = "sha256:155f9bk0rbaz9kf1isikmhls20vqyn9z0wikkbn6xraffqqwcc8g";
    };
  };
}
