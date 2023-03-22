{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "github_dark";
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
        soft-wrap.enable = false;
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
        # Horrible bodge for toggling spellcheck
        "[".o.s = ":lang markdown";
        "]".o.s = [":config-reload" ":lsp-restart"];
        "#" = "toggle_comments";
        "C-C" = "yank_main_selection_to_clipboard";
        "C-c" = "yank_joined_to_clipboard";
        "C-l" = ":reload";
        "C-v" = "replace_selections_with_clipboard";
        space.c.r = ":reset-diff-change";
        space.c.p = "goto_prev_change";
        space.c.n = "goto_next_change";
        space.e = ":reflow";
        space.n = ":new";
        space.space = "goto_last_accessed_file";
        space.q = ":q";
        space.Q = ":q!";
        space.w = ":w";
        space.W = ":w!";
        space.x = ":x";
        space.o.w = ":toggle-option soft-wrap.enable";
        space.o.c = ":toggle-option cursorline";
        Z = {
          d = "half_page_down";
          u = "half_page_up";
        };
      };
      keys.select = {
        "#" = "toggle_comments";
        "C-C" = "yank_main_selection_to_clipboard";
        "C-c" = "yank_joined_to_clipboard";
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
        text-width = 80;
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
