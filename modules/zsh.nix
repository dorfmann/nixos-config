{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "agnoster";
    };
    shellInit = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  users.defaultUserShell = pkgs.zsh;

}
