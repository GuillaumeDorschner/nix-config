hostname := `hostname -s`

default:
    just -l

rebuild:
    sudo nixos-rebuild switch --flake .#{{hostname}}

update:
    nix flake update

gc:
    sudo nix-collect-garbage -d

optimize:
    nix-store --optimise

check:
    nix flake check

diff:
    sudo nixos-rebuild build --flake .#
    nvd diff /run/current-system result

rollback:
    sudo nixos-rebuild switch --rollback

clean:
    git clean -d

iso:
    nix build .#nixosConfigurations.iso.config.system.build.isoImage
    @echo "ISO available at ./result/iso/*.iso"

vm: vm-build
    sudo ./result/bin/run-*-vm

vm-build:
    sudo nixos-rebuild build-vm --flake .#athena