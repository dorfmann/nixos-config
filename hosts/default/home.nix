{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rene";
  home.homeDirectory = "/home/rene";

  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/rene/.config/sops/age/keys.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    defaultSopsFile = ../../secrets/default.yaml;
    secrets.ssh_config = {
      path = "/home/rene/.ssh/config";
    };
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config = {
    # allow aunfree packages in home-manager
    allowUnfree = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # pkgs.hello
    #(pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    firefox
    vivaldi

    nixpkgs-fmt
    kate
    discord
    vscode
    kdeconnect
    protonvpn-gui
    thunderbird
    bitwarden
    thefuck

    git
    nodejs
    sqlite

    qemu
    libvirt
    virt-manager

    sops

    (writeShellScriptBin "nixi" ''
      sudo nixos-rebuild switch --flake ~/nixos#default
    '')

    (writeShellScriptBin "nixe" ''
      code ~/nixos
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".zshrc".source = ../../dotfiles/zshrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
