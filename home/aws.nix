{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      awscli2
      ssm-session-manager-plugin
      (writeShellScriptBin "ssm" (builtins.readFile ./ssm.sh))
      (buildGoModule rec {
        pname = "aws-console";
        version = "1.2.0";
        src = pkgs.fetchFromGitHub {
          owner = "aws-cloudformation";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-6YKZy6sdy1Yi2cDaLMA54GBTZ9uPhYi5Cq5QqCGbD5k=";
        };
        vendorSha256 = "sha256-e3R8+xarofbx3Ky6JIfDbysTQETCUaQj/QmzAiU7fZk=";
        subPackages = ["cmd/aws-console"];
      })
    ];

    programs.fish = {
      interactiveShellInit = ''
        # Enable AWS CLI autocompletion (https://github.com/aws/aws-cli/issues/1079):
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
      '';
      shellAbbrs = {
        ao = "aws-console -p";
      };
    };
  };
}