{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.python312 ];
}
