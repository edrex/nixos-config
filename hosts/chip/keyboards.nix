{ ... }:

{
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

  services.udev.extraHwdb = ''
# this matches all input devices i think
evdev:input:*
 KEYBOARD_KEY_700e2=leftmeta
 KEYBOARD_KEY_700e6=rightmeta
 KEYBOARD_KEY_700e3=leftalt
 KEYBOARD_KEY_70039=esc

# from evemu-describe
evdev:input:b0011v0001p0001*
## evdev:atkbd:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
 KEYBOARD_KEY_3a=esc
 KEYBOARD_KEY_38=leftmeta
 KEYBOARD_KEY_b8=rightmeta
 KEYBOARD_KEY_db=leftalt

# evdev:name:Kinesis KB800MB-BT:dmi:bvn*:bvr*:bd*:svn*:pn*

evdev:input:b0005v0A5Cp8502*
 KEYBOARD_KEY_70039=esc
 KEYBOARD_KEY_70069=brightnessdown
 KEYBOARD_KEY_7006a=brightnessup
 KEYBOARD_KEY_700e2=leftalt # undo the generic mapping because they're switched on this mac-specific model
 KEYBOARD_KEY_700e3=leftmeta
'';
}