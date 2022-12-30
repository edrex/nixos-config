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
    extraOptions = ["-q never"]; # Avoid error if no devices
    # No hotplug support, see https://www.smartmontools.org/ticket/1014
    # TODO: look into sending smartd SIGHUP when udev sees new HD
    # See https://unix.stackexchange.com/questions/28548/how-to-run-custom-scripts-upon-usb-device-plug-in
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
