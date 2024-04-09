{ config, pkgs, ... }:

{
  #Rootless Docker     
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
