{ config, pkgs, ... }:

{
  # for hardware / bare metal systems

  # TODO(eric): split out hard drive profile
  # check S.M.A.R.T status of all disks and notify in case of errors
  services.smartd = {
    enable = true;
    notifications = {
      mail.enable = if config.services.postfix.enable then true else false;
      #test = true;
    };
  };

  # install packages
  environment.systemPackages = with pkgs; [
    lshw
    usbutils
    pciutils
    dmidecode
    lm_sensors
    smartmontools
  ];

}
