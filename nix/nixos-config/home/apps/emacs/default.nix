{config, pkgs, lib, ... }:
{
  # Crib:
  # https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix
  services.emacs.package = pkgs.emacsPgtkNativeComp;
  home.packages = with pkgs; [
    ## Emacs itself
    binutils       # native-comp needs 'as', provided by this
    ## Wayland enabled 29 + native-comp
    ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages
      (epkgs: [ epkgs.vterm ]))
    pandoc

    ## Doom dependencies
    git
    (ripgrep.override {withPCRE2 = true;})
    gnutls              # for TLS connectivity

    ## Optional dependencies
    fd                  # faster projectile indexing
    imagemagick         # for image-dired
    # FIXME: merge home stuff with main config
    # (lib.mkIf (config.programs.gnupg.agent.enable)
      pinentry_emacs   # in-emacs gnupg prompts
    zstd                # for undo-fu-session/undo-tree compression

    ## Module dependencies
    # :checkers spell
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    sqlite
  ];

# ...

  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  # };

}
