{ pkgs, ... }:

{
 # install packages
  environment.systemPackages = [
    pkgs.evtest
  ];

  # Guide to remapping keys on Linux using hwdb files
  # https://www.reddit.com/r/linux_gaming/comments/nypsi1/updated_guide_to_remapping_keys_on_linux_using/

  # remap capslock -> esc, and switch lalt <-> lmeta
  # reload rules:
  # sudo systemd-hwdb update # done by nixos
  # sudo udevadm trigger

  # show keypress codes for device:
  # sudo evtest # (not showkey -s)
  # https://ask.fedoraproject.org/en/question/46201/how-to-map-scancodes-to-keycodes/

  # udevadm info /dev/input/event18|grep KEY

  # Question: how to match all keyboards?
  # Doesn't seem possible anymore:
  # https://fossies.org/linux/systemd/hwdb/parse_hwdb.py

  # see also https://github.com/systemd/systemd/blob/main/hwdb.d/60-keyboard.hwdb
  services.udev.extraHwdb = ''
# this matches all input devices i think
# bad idea since it results in lots of err: failed to call EVIOCSKEYCODE with scan code 
# evdev:input:*
evdev:name:Goldtouch Bluetooth Keyboard:dmi:bvn*:bvr*:bd*:svn*:pn*
 KEYBOARD_KEY_700e2=leftmeta
 KEYBOARD_KEY_700e3=leftalt
 KEYBOARD_KEY_700e6=rightmeta
 KEYBOARD_KEY_700e7=rightalt
 KEYBOARD_KEY_70039=esc

# from evemu-describe
# builtin keyboard
evdev:input:b0011v0001p0001*
## evdev:atkbd:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
 KEYBOARD_KEY_3a=esc
 KEYBOARD_KEY_38=leftmeta
 KEYBOARD_KEY_b8=rightmeta
 KEYBOARD_KEY_db=leftalt


evdev:input:b0005v0A5Cp8502*
 KEYBOARD_KEY_70039=esc
 KEYBOARD_KEY_70069=brightnessdown
 KEYBOARD_KEY_7006a=brightnessup
 KEYBOARD_KEY_700e2=leftalt # undo the generic mapping because they're switched on this mac-specific model
 KEYBOARD_KEY_700e3=leftmeta
'';
}
