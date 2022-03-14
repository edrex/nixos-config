{ config, lib, pkgs, modulesPath, ... }:
# https://discourse.nixos.org/t/how-to-tell-kernel-to-use-a-custom-modeline/5500
let 
  dest = "lib/firmware/edid";
  path = "${dest}/chipedp.bin";
  # package for edid firmware
  chip_edid = pkgs.runCommand filename {} ''
    mkdir -p $out/${dest}
    cp ${./${filename}} $out/${dest}/${filename}
  '';
in {
  # add pkg to firmware
  hardware.firmware = [ chip_edid ];
  boot.initrd.extraFiles."${path}".source = pkgs.runCommandLocal "${path}" {} "cp ${./chipedp.bin} $out";
  # add kernel param
  boot.kernelParams = [ "drm.edid_firmware=eDP-1:edid/chipedp.bin" ];
}
