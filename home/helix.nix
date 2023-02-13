{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "custom";
      editor = {
        cursorline = true;
        auto-save = true;
        line-number = "relative";
        color-modes = true;
        file-picker.hidden = false;
        indent-guides = {
          render = true;
          character = "╎";
        };
        soft-wrap = {
          enable = true;
        };
        whitespace = {
          render = {
            space = "none";
            tab = "none";
            newline = "all";
          };
          characters = {
            newline = "↩";
          };
        };
      };
      keys.normal = {
        space.e = ":reflow";
        space.q = ":q";
        space.w = ":w";
        space.x = ":x";
        space.o.w = ":toggle-option soft-wrap.enable";
        space.o.c = ":toggle-option cursorline";
        Z = {
          d = "half_page_down";
          u = "half_page_up";
        };
      };
    };
    themes = {
      custom = {
        "inherits" = "catppuccin_mocha";
        "ui.statusline.normal" = {
          fg = "base";
          bg = "lavender";
        };
        "ui.statusline.insert" = {
          fg = "base";
          bg = "green";
        };
        "ui.statusline.select" = {
          fg = "base";
          bg = "yellow";
        };
        "ui.cursor.primary.normal" = {
          fg = "base";
          bg = "lavender";
        };
        "ui.cursor.primary.insert" = {
          fg = "base";
          bg = "green";
        };
        "ui.cursor.primary.select" = {
          fg = "base";
          bg = "yellow";
        };
        # The non-primary cursor colours need to be a dimmed version of the above
        "ui.cursor.normal" = {
          fg = "base";
          bg = "#A6ADC8";
        };
        "ui.cursor.insert" = {
          fg = "base";
          bg = "#AACCC6";
        };
        "ui.cursor.select" = {
          fg = "base";
          bg = "#B6A98B";
        };
      };
    };
    languages = [
      {
        # Use ltex-ls an an alternative LSP for Markdown, to provide spelling suggestions
        # https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers#markdown
        name = "markdown";
        language-server = {command = "ltex-ls";};
        file-types = ["md"];
        scope = "source.markdown";
        roots = [];
        max-line-length = 80;
      }
      {
        name = "json";
        language-server = {
          command = "vscode-json-languageserver";
          args = ["--stdio"];
        };
      }
      {
        name = "nix";
        formatter = {
          command = "alejandra";
          args = ["-"];
        };
        auto-format = true;
      }
    ];
  };

  # Language servers
  home.packages = with pkgs; [
    alejandra
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    nil
    ltex-ls
    terraform-ls
  ];
}
