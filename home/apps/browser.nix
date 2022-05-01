{ pkgs, ... }: {
   
  home.packages = with pkgs; [
    # vivaldi
    firefox-wayland
    chromium
    qutebrowser
  ];
  programs = {
    browserpass.enable = true;
    chromium = {
      enable = true;
      extensions = [
        { id = "fkeaekngjflipcockcnpobkpbbfbhmdn"; } # copy as markdown
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "naepdomgkenhinolocfifgehidddafch"; } # browserpass
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        {
          id = "dcpihecpambacapedldabdbpakmachpb";
          updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/src/updates/updates.xml";
        }

      ];
    };
  };
  # TODO: tweaks to enable accel
  # https://forum.manjaro.org/t/howto-enable-hardware-video-acceleration-video-decode-in-google-chrome-brave-vivaldi-and-opera-browsers/51895
  # chrome://gpu/
}