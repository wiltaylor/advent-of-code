{
  description = "Go development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = { allowUnfree = "true";};
    };
  in rec {
    devShell.x86_64-linux = import ./shell.nix { inherit pkgs;};
  };
}
