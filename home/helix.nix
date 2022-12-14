{ pkgs, unstable, ... }: {

  programs.helix = {
    enable = true;
    package = unstable.helix;
    settings = {
      theme = "onedark";
      editor = {
        cursorline = true;
        auto-save = true;
        line-number = "relative";
        cursor-shape.insert = "bar";
        color-modes = true;
        file-picker.hidden = false;
      };
    };
    languages = [{
      # Use ltex-ls an an alternative LSP for Markdown, to provide spelling suggestions
      # https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers#markdown
      name = "markdown";
      language-server = { command = "ltex-ls"; };
      file-types = [ "md" ];
      scope = "source.markdown";
      roots = [];
    }];
  };

  # Language servers
  home.packages = with pkgs; [
    nil
    ltex-ls
    terraform-ls
  ];

}