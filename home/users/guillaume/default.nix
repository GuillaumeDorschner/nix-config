{
  imports = [
    ../../core
    ../../optional/brave.nix
    ../../optional/plasma.nix
    ../../optional/vscode.nix
  ];

  home.username = "guillaume";
  home.homeDirectory = "/home/guillaume";

  # TODO: make profile picture a service ?
  # home.file."/var/lib/AccountsService/icons/guillaume".source = ./asserts/profile_picture.png;
  home.stateVersion = "25.11";
}
