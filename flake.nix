{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-master, chaotic, home-manager, hyprland }: {
    defaultPackage = home-manager.defaultPackage;
    homeConfigurations = {
      marc = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          # required by logseq and obsidian
          config.permittedInsecurePackages = [
            "electron-25.9.0"
            "electron-27.3.11"
          ];
        };
        extraSpecialArgs = { 
          pkgs-unstable = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [ ./home.nix ];
      };
    };
    nixosConfigurations = {
      "marc-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	      modules = [ ./system/laptop.nix ];
      };
      "marc-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./system/desktop.nix 
          hyprland.nixosModules.default
        ];
      };
    };
  };
}
