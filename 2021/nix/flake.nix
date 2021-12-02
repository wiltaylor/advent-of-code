{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: 
  let 
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };

    day1 = import ./day1.nix;

  in {

    packages.x86_64-linux.day1-1 = pkgs.writeText "day01-1" day1.part1;
    packages.x86_64-linux.day1-2 = pkgs.writeText "day01-2" day1.part2;
  };
}
