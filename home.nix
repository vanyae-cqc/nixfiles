{ config, pkgs, lib, ... }:

{
  # Information about you and the paths home manager should manage.
  home.username = "vanyaeccles";
  home.homeDirectory = "/Users/vanyaeccles";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnumake
    graphviz
    bat
    pyenv
    awscli2
    devenv
    cachix
    pandoc
    keepassxc
    rectangle
    iterm2
    direnv
    ghc
    htop
    postgresql_14
    k9s
    nodejs
    rustup
    terraform
    yamllint
    zsh 
    neofetch    

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vanyaeccles/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/nixfiles/scripts"
  ];

  home.activation = {
    rectangle = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${config.home.homeDirectory}/nixfiles/scripts/open_rectangle.sh &
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.git = {
    enable = true;
    userName = "vanyae-cqc";
    userEmail = "vanya.eccles@quantinuum.com";

    extraConfig = {
      # Add a Git alias to run git-browse.sh
      alias.browse = "!~/nixfiles/git-browse.sh";
      # alias to list branches in the current repo
      alias.lb = "for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
