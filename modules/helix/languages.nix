{
  config,
  lib,
  pkgs,
  ...
}:
[
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
]
++ (lib.lists.optionals config.hxy.aws-tools.enable [
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
])
