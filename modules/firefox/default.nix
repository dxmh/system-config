{
  config,
  lib,
  ...
}: {
  options.hxy.firefox = {
    enable = lib.mkEnableOption "Enable Firefox configuration";
    extraAddons = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra Firefox addons to be installed";
    };
  };

  config = lib.mkIf config.hxy.firefox.enable {
    home-manager.users.${config.hxy.base.mainUser}.programs.firefox = {
      enable = true;

      # https://discourse.nixos.org/t/nix-macos-monthly/1230/9
      package = config.nur.repos.toonn.apps.firefox;

      extensions =
        config.hxy.firefox.extraAddons
        ++ [
          config.nur.repos.rycee.firefox-addons.amp2html
          config.nur.repos.rycee.firefox-addons.clearurls
          config.nur.repos.rycee.firefox-addons.consent-o-matic
          config.nur.repos.rycee.firefox-addons.cookie-autodelete
          config.nur.repos.rycee.firefox-addons.df-youtube
          config.nur.repos.rycee.firefox-addons.old-reddit-redirect
          config.nur.repos.rycee.firefox-addons.reddit-enhancement-suite
          config.nur.repos.rycee.firefox-addons.tab-reloader
          config.nur.repos.rycee.firefox-addons.ublock-origin
          config.nur.repos.rycee.firefox-addons.view-image
          config.nur.repos.rycee.firefox-addons.vimium
        ];

      profiles.default = {
        id = 0;
        isDefault = true;
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        settings = import ./settings.nix;
        bookmarks = import ./bookmarks.nix;
      };
    };
  };
}
