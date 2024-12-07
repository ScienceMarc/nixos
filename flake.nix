{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyperland.url = "github:hyprwm/Hyprland";
  };
  outputs = inputs: with inputs; {
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
        modules = [ ./system/desktop.nix ];
      };
    };
  };
}
