{ pkgs, ... }: {
  # TODO: this should just be a package?
  home.packages = with pkgs; [
    slurp
    grim
    libnotify # TODO: depend on module instead?
    wl-clipboard #TODO: ditto
    (pkgs.writeShellScriptBin "screenshot" ''
      # set -xe
      # cancel if no selection
      GEOM=$(slurp) || exit $?
      NAME=Screenshot-$(date +%Y-%m-%d-%H:%M).png
      DIR="$HOME/Pictures"
      [ -d "$DIR" ] || mkdir "$DIR"
      FILE="$DIR/$NAME"
      sleep 2
      grim -g "$GEOM" "$FILE"
      wl-copy "$FILE"
      notify-send "Copied screenshot to clipboard" "$NAME"
      echo "$FILE"
    '')
  ];
}