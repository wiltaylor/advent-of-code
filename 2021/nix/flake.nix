{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: 
  let 
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {

    packages.x86_64-linux.day01 = pkgs.writeText "day01" (import ./day01.nix);
    packages.x86_64-linux.day02 = pkgs.writeText "day02" (import ./day02.nix);
  };
}
