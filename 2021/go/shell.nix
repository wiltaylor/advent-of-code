{ pkgs ? <nixpkgs> }:
pkgs.mkShell {
  name = "golangdevshell";
  buildInputs = with pkgs; [
    go
    dep2nix
    xlibsWrapper
    delve
  ];

  shellHook = ''
    echo "Advant of code"
    export EDITOR=vim
  '';
}
