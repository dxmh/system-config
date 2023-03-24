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
        whitespace.render = {
          space = "none";
          tab = "none";
          newline = "all";
        };
        whitespace.characters = {
          newline = "↩";
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
        language-server.command = "${pkgs.ltex-ls}/bin/ltex-ls";
        file-types = ["md"];
        scope = "source.markdown";
        roots = [];
        text-width = 80;
      }
      {
        name = "json";
        auto-format = true;
        language-server.command = "${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver";
        language-server.args = ["--stdio"];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        formatter.args = ["-"];
        language-server.command = "${pkgs.nil}/bin/nil";
      }
      {
        name = "bash";
        language-server.command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        language-server.args = ["start"];
      }
      {
        name = "hcl";
        auto-format = true;
        language-server.command = "${pkgs.terraform-ls}/bin/terraform-ls";
        language-server.args = ["serve"];
        language-server.language-id = "terraform";
      }
      {
        name = "tfvars";
        auto-format = true;
        language-server.command = "${pkgs.terraform-ls}/bin/terraform-ls";
        language-server.args = ["serve"];
        language-server.language-id = "terraform-vars";
      }
    ];
  };
}
