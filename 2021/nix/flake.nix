{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: 
  let 
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {

    packages.x86_64-linux.day1 = pkgs.writeText "day01" (import ./day1.nix);
    packages.x86_64-linux.day2 = pkgs.writeText "day02" (import ./day2.nix);
  };
}
