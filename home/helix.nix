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
        indent-guides = {
          render = true;
          character = "┊";
        };
        whitespace = {
          render = {
            space = "none";
            tab = "none";
            newline = "all";
          };
          characters = {
            newline = "🢱";
          };
        };
      };
    };
    languages = [
      {
        # Use ltex-ls an an alternative LSP for Markdown, to provide spelling suggestions
        # https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers#markdown
        name = "markdown";
        language-server = { command = "ltex-ls"; };
        file-types = [ "md" ];
        scope = "source.markdown";
        roots = [];
      }
      {
        name = "json";
        language-server = {
          command = "vscode-json-languageserver";
          args = ["--stdio"];
        };
      }
    ];
  };

  # Language servers
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    nil
    ltex-ls
    terraform-ls
  ];

}