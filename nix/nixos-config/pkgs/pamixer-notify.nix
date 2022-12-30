{ pkgs, writeShellApplication }:

writeShellApplication {
  name = "pamixer-notify";

  runtimeInputs = with pkgs; [ libnotify wireplumber];

  text = ''
    number=$(pamixer "$@" --get-volume)
    icon="multimedia-volume-control"
    notify-send -t 1000 " " -i "$icon" -h "int:value:$number" -h string:synchronous:volume
  '';
}
