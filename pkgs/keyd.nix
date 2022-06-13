{ lib, stdenv, python39Packages, python39, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "keyd";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "keyd";
    rev = "v${version}";
    sha256 = "sha256-YZSwXDrzly5OlNh8j+Y2/qYmGHXE5T3ZAvq7e45jVL0=";
  };

  makeFlags = [ "DESTDIR=${placeholder "out"}" ];

  buildInputs = [ python3 python3Packages.xlib ];

  meta = with lib; {
    homepage = "https://github.com/rvaiya/keyd";
    description = "A key remapping daemon for linux";
    longDescription = ''
      Keyd has several unique features many of which are traditionally
      only found in custom keyboard firmware like QMK as well as some
      which are unique to keyd.
      It expects a configuration file at /etc/keyd/default.conf. For
      more details check out the homepage.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ dit7ya cidkid ];
    platforms = platforms.linux;
  };
}