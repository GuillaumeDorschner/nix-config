{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      url = "git+ssh://git@github.com/GuillaumeDorschner/nix-secrets.git?ref=main&shallow=1";
    };
    nixos-anywhere = {
      # TODO: create the anywhere script
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      flake = {
        # NixOS machines
        nixosConfigurations =
          let
            mkNixos =
              host: system:
              inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit inputs;
                  inherit host;
                  user = "guillaume"; # TODO: make user define in the host
                };
                modules = [
                  inputs.sops-nix.nixosModules.sops
                  inputs.home-manager.nixosModules.home-manager
                  ./hosts/${host}
                  (import-tree ./nixos/core)
                ];
              };
          in
          {
            athena = mkNixos "athena" "x86_64-linux";
            ares = mkNixos "ares" "x86_64-linux";
          };
        # macOS machine
        # TODO: make one output with all the options     systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
        darwinConfigurations.plutus = inputs.nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            user = "guillaume";
          };
          modules = [
            inputs.home-manager.darwinModules.home-manager
            ./hosts/plutus
            (import-tree ./darwin)
          ];
        };
      };
    };
}

# modules = [
#   {
#     home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
#     home-manager.users.guillaume = import ./home-guillaume.nix;
#   }
# ];
