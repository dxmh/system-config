{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.aws-tools.enable = lib.mkEnableOption "Enable tools for working with AWS";

  config = lib.mkIf config.hxy.aws-tools.enable {
    home-manager.users.${config.hxy.base.mainUser} = {
      home.packages = with pkgs; [
        awscli2
        ssm-session-manager-plugin
        terraform
        (writeShellScriptBin "ssm" (builtins.readFile ./ssm.sh))
        (writeShellScriptBin "ecsh" (builtins.readFile ./ecsh.sh))
        (writeShellScriptBin "acon" (builtins.readFile ./acon.sh))
        (buildGoModule rec {
          pname = "aws-console";
          version = "1.2.0";
          src = pkgs.fetchFromGitHub {
            owner = "aws-cloudformation";
            repo = pname;
            rev = "v${version}";
            sha256 = "sha256-6YKZy6sdy1Yi2cDaLMA54GBTZ9uPhYi5Cq5QqCGbD5k=";
          };
          vendorHash = "sha256-e3R8+xarofbx3Ky6JIfDbysTQETCUaQj/QmzAiU7fZk=";
          subPackages = ["cmd/aws-console"];
        })
      ];

      programs.fish = lib.mkIf config.hxy.fish.enable {
        # Enable AWS CLI autocompletion (https://github.com/aws/aws-cli/issues/1079):
        interactiveShellInit = ''
          complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
        '';
        shellAbbrs = {
          ao = "aws-console -p";
          tfm = "terraform";
        };
      };
    };
  };
}
