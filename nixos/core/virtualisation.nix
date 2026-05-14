{ pkgs, user, ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "guillaume" ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    vmVariant.virtualisation = {
      memorySize = 14240;
      cores = 8;
      sharedDirectories.keys = {
        source = "/var/lib/sops-nix";
        target = "/var/lib/sops-nix";
      };
    };
  };
}
