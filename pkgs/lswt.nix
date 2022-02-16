{ lib, stdenv, fetchFromSourcehut, nixos, wayland }:

stdenv.mkDerivation rec {
  pname = "lswt";
  version = "v1.0.4";

  buildInputs = [ wayland ];

  src = fetchFromSourcehut {
    owner = "~leon_plickat";
    repo = pname;
    rev = version;
    sha256 = "sha256-Orwa7sV56AeznEcq/Xj5qj4PALMxq0CI+ZnXuY4JYE0=";
  };

  makeFlags = [
    "DESTDIR=${placeholder ''out''}"
    "PREFIX="
  ];

  meta = with lib; {
    description = "A command that lists Wayland toplevels";
    homepage = "https://git.sr.ht/~leon_plickat/lswt";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}