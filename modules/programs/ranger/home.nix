{ pkgs, user, ... }:

{
    home.file.".config/ranger/command.py".source = ./ranger/commands.py;
    home.file.".config/ranger/rc.conf".source = ./ranger/rc.conf;
    home.file.".config/ranger/scope.sh".source = ./ranger/scope.sh;
}
