{ config, pkgs, lib, ... }:
let
  # https://www.ertt.ca/nix/shell-scripts/
  # pkgScript = name: args:
  #   resholve.writeScriptBin name args (builtins.readFile (./cmd + "/${name}"));
  pkgCmd = name:
    pkgs.writeScriptBin name (builtins.readFile (./cmd + "/${name}"));
  
in {
  home.packages = [
    (pkgCmd "workon")
    # (pkgScript "exec-with-pwd" {
    #   inputs = [pkgs.sway pkgs.jq pkgs.awk];
    # })
    pkgs.gitui
  ];
  home.sessionVariables = {
    VISUAL = "${pkgs.helix}/bin/hx";
  };
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        g = "git";
        gi = "gitui";
        e = "hx";
        d = "date +%Y-%m-%d";
        j = "cd ~/wiki && e ~/wiki/$(d).md";
        # avoid nested shells so exec-with-pwd can find PWD
        # todo: make this a loop over a command set
        workon = "exec workon";
      };
    };

    git = {
      enable = true;
      userName = "Eric Drechsel";
      userEmail = "eric@pdxhub.org";
      extraConfig = {
        init.defaultBranch = "main";
        push = { default = "current"; };
        pull = { rebase = true; };
      };
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    # bat.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
    jq.enable = true;
  };
}
