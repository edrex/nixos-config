{ pkgs, inputs}:
inputs.devenv.lib.mkShell
{
  inherit inputs pkgs; # needed for mkShell
  modules = [
    {
      enterShell = ''
        echo a nice install shell with lazygit, hx, and ranger 
      '';
      packages = with pkgs; [
        gitFull
        gh
        lazygit
        ranger
        helix
        nil
      ];
    }
  ];
}
