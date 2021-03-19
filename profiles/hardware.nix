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
    # evdev testing stuff
    evtest

  ];


  # reload rules:
  # sudo systemd-hwdb update && sudo udevadm trigger

  # show keypress codes for device:
  # sudo evtest (not showkey -s)
  # (value field)
  # Source: 
  # https://ask.fedoraproject.org/en/question/46201/how-to-map-scancodes-to-keycodes/
  # https://yulistic.gitlab.io/2017/12/linux-keymapping-with-udev-hwdb/

  # udevadm info /dev/input/event18|grep KEY
    # # from evemu-describe
    # ## evdev:atkbd:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
    # evdev:input:b0011v0001p0001*
    #   KEYBOARD_KEY_3a=esc
    #   KEYBOARD_KEY_38=leftmeta
    #   KEYBOARD_KEY_b8=rightmeta
    #   KEYBOARD_KEY_db=leftalt

    # # evdev:name:Kinesis KB800MB-BT:dmi:bvn*:bvr*:bd*:svn*:pn*

    # evdev:input:b0005v0A5Cp8502*
    #   KEYBOARD_KEY_70039=esc
    #   KEYBOARD_KEY_70069=brightnessdown
    #   KEYBOARD_KEY_7006a=brightnessup
    #   KEYBOARD_KEY_700e2=leftalt # undo the generic mapping because they're switched on this mac-specific model
    #   KEYBOARD_KEY_700e3=leftmeta

  services.udev.extraHwdb = ''
    # this matches all input devices i think
    keyboard:usb:v*p*
      KEYBOARD_KEY_700e2=leftmeta
      KEYBOARD_KEY_700e6=rightmeta
      KEYBOARD_KEY_700e3=leftalt
      KEYBOARD_KEY_70039=esc
  '';
}
