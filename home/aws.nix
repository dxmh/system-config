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
    ];

    # Enable AWS CLI autocompletion (https://github.com/aws/aws-cli/issues/1079):
    programs.fish.interactiveShellInit = ''
      complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    '';
  };
}
