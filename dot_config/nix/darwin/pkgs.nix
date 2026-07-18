{ pkgs, ... }:

{
  environment.systemPackages = import ../common/packages.nix { inherit pkgs; };
}
