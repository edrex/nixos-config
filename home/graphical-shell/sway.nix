{ pkgs, config, nixosConfig, lib, ... }:
# TODO: let's split all the non-sway stuff off, and make it work with river too
# kitchen sink config I can crib off of:
# https://github.com/cole-mickens/nixcfg/blob/main/mixins/sway.nix
# https://git.sr.ht/~jshholland/nixos-configs/tree/master/home/sway.nix
  /*
  - [ ] wrapper is provided by hm?
  */
let
  # TODO: Menu
  # TODO: https://github.com/altdesktop/playerctl
  # idle/lock
  # TODO: test and fix/ remove this message
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock";
  idlecmd = ''${pkgs.swayidle}/bin/swayidle -w \
    lock \"${swaylockcmd}\" \
    timeout 600 \"${pkgs.systemd}/bin/systemctl suspend\" \
    resume 'swaymsg \"output * dpms on\"' '';
  #term = "exec-with-pwd $TERMINAL";
  #TODO: is this in my sway env already?
  term = config.home.sessionVariables.TERMINAL;
in 
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      startup = [
        { always = true; command = "${pkgs.systemd}/bin/systemd-notify --ready || true"; }
        { always = true; command = "${idlecmd}"; }
        { command = "${pkgs.poweralertd}/bin/poweralertd"; }
        # work around https://github.com/emersion/kanshi/issues/43
        { always = true; command = "systemctl --user restart kanshi.service"; }
      ];
      input = {
        "type:touchpad" = {
          tap = "enabled";
          dwt = "enabled";
        };
        "1267:8400:ELAN_Touchscreen" = {
          map_to_output = "eDP-1";
        };
      };

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        dirBind = f: lib.attrsets.mapAttrs' f {
          h = "left";
          l = "right";
          j = "down";
          k = "up";
          Left = "left";
          Right = "right";
          Down = "down";
          Up = "up";
        };
      in lib.mkOptionDefault ({

        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+c" = "exec ${pkgs.rofimoji}/bin/rofimoji -a clipboard";

        "${modifier}+Return" = "exec ${term}";
	      "${modifier}+Shift+grave" = "move scratchpad";
	      "${modifier}+grave" = "scratchpad show";

	      "${modifier}+Ctrl+s" = "exec screenshot";

        # TODO: notif, maybe wob 
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +2%";
        "XF86MonBrightnessDown"  = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        "Shift+XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +10%";
        "Shift+XF86MonBrightnessDown"  = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer-notify}/bin/pamixer-notify -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer-notify}/bin/pamixer-notify -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer-notify}/bin/pamixer-notify -t";
        
        # toggle hide bar
	      "${modifier}+Shift+b" = "bar mode toggle";
	      # "${modifier}+Shift+b" = "exec killall -SIGUSR1 waybar";

        "${modifier}+XF86AudioMute" = "mode passthrough";
      } // dirBind (dirKey: dir: { name = "${modifier}+Ctrl+Shift+${dirKey}"; value = "move workspace to output ${dir}";}));
      modes = {
        passthrough = {
          "${modifier}+XF86AudioMute" = "mode default";
        };
      };

      # clearly mark xwayland windows
      window.commands = [
        { command = "title_format \"<span background='#FFA0A0' foreground='#000000'>%title</span>\""; criteria = { shell = "xwayland"; } ; }
      ];
/*
# scroll wheel on lauren's mouse is slooooowwwww
#input "1118:1957:Microsoft_Microsoft___2.4GHz_Transceiver_v9.0_Mouse" scroll_factor 10
input "1452:781:Dennis___s_Mouse" scroll_factor 3

font pango:DejaVu Sans Mono 10
for_window [class=".*"] title_format "<span background='#ff0000'>%title</span>"

exec blueman-applet
exec fnott # notifications
# exec gammastep-indicator
exec poweralertd
exec wlsunset -l 45.5 -L -122.6
#exec albert #launcher
exec swaymsg command seat "*" hide_cursor 5000

for_window [instance=mpv] floating enable, sticky enable
for_window [app_id="firefox"] inhibit_idle fullscreen
# for_window [shell="xdg"] title_format '[%app_id] %title'
for_window [shell="xdg"] title_format '%title'
for_window [shell="xwayland" ] title_format '[X11] %title'

set $mod Mod4
set $left h
set $down j
set $up k
set $right l

# waiting for clipboard support
#set $term alacritty
#set $term kitty
set $term exec-with-pwd $TERMINAL
set $interm $term
set $floatterm floatterm
set $menu  "wofi -p 'Type app or command' --show drun,run -i"
#set $menu  "dmenu"
#set $menu "albert toggle"
set $winmenu "i3-windows-and-run --menu \"wofi\" -- -id"

bindsym $mod+Return exec $term
#bindsym $mod+Shift+Return exec $interm code .
bindsym $mod+d exec $menu
bindsym $mod+Space exec i3cmd_exec "floating enable" foot tydra ~/src/github.com/edrex/begin/actions.yaml
bindsym $mod+Shift+d exec $winmenu
bindsym $mod+Shift+r reload
bindsym $mod+m exec wlr-randr --output eDP-1 --off --output DP-1 --transform normal
#assign [title="journal"] 8
# bindsym $mod+i exec $interm journal -p
bindsym $mod+i exec org-capture
bindsym $mod+Shift+i exec $interm journal -pf
bindsym $mod+o exec $interm wf
bindsym $mod+Shift+o exec $interm wff

bindsym $mod+Ctrl+s exec "screenshot"
# start recording a video
bindsym $mod+Ctrl+Shift+s exec $interm "screencap"
bindsym $mod+n exec "emacsclient -nc"
bindsym $mod+Shift+n exec "networkmanager_dmenu"
bindsym $mod+b exec "btmenu"
bindsym $mod+g exec "wl-gammactl"

floating_modifier $mod normal
bindsym $mod+Shift+e exit

# Move your focus around
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
# or use $mod+[up|down|left|right]
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# _move_ the focused window with the same, but add Shift
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
# ditto, with arrow keys
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# move workspace to other output
bindsym $mod+Ctrl+Shift+$left move workspace to output left
bindsym $mod+Ctrl+Shift+$down move workspace to output down
bindsym $mod+Ctrl+Shift+$up move workspace to output up
bindsym $mod+Ctrl+Shift+$right move workspace to output right
# ditto, with arrow keys
bindsym $mod+Ctrl+Shift+Left move workspace to output left
bindsym $mod+Ctrl+Shift+Down move workspace to output down
bindsym $mod+Ctrl+Shift+Up move workspace to output up
bindsym $mod+Ctrl+Shift+Right move workspace to output right
# move focus between workspaces
bindsym $mod+Ctrl+$left focus workspace left
bindsym $mod+Ctrl+$right focus workspace right
#bindsym $mod+Ctrl+Left focus workspace left
#bindsym $mod+Ctrl+Down move workspace to output down
#bindsym $mod+Ctrl+Up move workspace to output up
#bindsym $mod+Ctrl+Right move workspace to output right
#
#
# Workspaces:

    bindsym Mod4+Tab workspace next_on_output
    bindsym Mod4+Shift+Tab workspace prev_on_output
	# create next available workspace on current output
	bindsym $mod+Minus exec i3-empty
	bindsym $mod+Shift+Minus exec i3-empty -m

    # switch to workspace
    bindsym $mod+1 workspace 1
    bindsym $mod+2 workspace 2
    bindsym $mod+3 workspace 3
    bindsym $mod+4 workspace 4
    bindsym $mod+5 workspace 5
    bindsym $mod+6 workspace 6
    bindsym $mod+7 workspace 7
    bindsym $mod+8 workspace 8
    bindsym $mod+9 workspace 9
    bindsym $mod+0 workspace 10
    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace 1
    bindsym $mod+Shift+2 move container to workspace 2
    bindsym $mod+Shift+3 move container to workspace 3
    bindsym $mod+Shift+4 move container to workspace 4
    bindsym $mod+Shift+5 move container to workspace 5
    bindsym $mod+Shift+6 move container to workspace 6
    bindsym $mod+Shift+7 move container to workspace 7
    bindsym $mod+Shift+8 move container to workspace 8
    bindsym $mod+Shift+9 move container to workspace 9
    bindsym $mod+Shift+0 move container to workspace 10
    # Note: workspaces can have any name you want, not just numbers.
    # We just use 1-10 as the default.
#
# Layout stuff:
#
    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    #bindsym $mod+b splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen toggle
    bindsym $mod+Shift+f fullscreen toggle global

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle
    bindsym $mod+Shift+s sticky toggle

    # Swap focus between the tiling area and the floating area
    # bindsym $mod+space focus mode_toggle

    # move focus to the parent container
    bindsym $mod+a focus parent

	# focus the child container
	bindsym $mod+Shift+a focus child

#
# Marks
#

	# read 1 character and mark the current window with this character
	bindsym $mod+Shift+z exec i3-input -F 'mark %s' -l 1 -P 'Mark: '

	# read 1 character and go to the window with the character
	bindsym $mod+z exec i3-input -F '[con_mark="%s"] focus' -l 1 -P 'Goto: '

#
# Scratchpad:
#
    # Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
		bindsym $mod+Shift+grave move scratchpad
    # bindsym $mod+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
		bindsym $mod+grave scratchpad show
    # bindsym $mod+minus scratchpad show
#
# Resizing containers:
#
mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym $left resize shrink width 10 px or 10 ppt
    bindsym $down resize grow height 10 px or 10 ppt
    bindsym $up resize shrink height 10 px or 10 ppt
    bindsym $right resize grow width 10 px or 10 ppt

    # ditto, with arrow keys
    bindsym Left resize shrink width 10 px or 10 ppt
    bindsym Down resize grow height 10 px or 10 ppt
    bindsym Up resize shrink height 10 px or 10 ppt
    bindsym Right resize grow width 10 px or 10 ppt

    # return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"


# toggle hide bar
# bindsym $mod+Shift+b bar mode toggle
bindsym $mod+Shift+b killall -SIGUSR1 waybar
# targets currently active output
# http://blog.kopis.de/2015/07/21/changing-volume-using-pactl/
bindsym XF86AudioRaiseVolume exec pactl set-sink-volume $(pactl list short sinks|grep RUNNING|awk '{print $1}') +5% #increase sound volume
bindsym XF86AudioLowerVolume exec pactl set-sink-volume $(pactl list short sinks|grep RUNNING|awk '{print $1}') -5% #decrease sound volume
bindsym XF86AudioMute exec pactl set-sink-mute $(pactl list short sinks|grep RUNNING|awk '{print $1}') toggle # mute sound

# Screen brightness controls
bindsym XF86MonBrightnessUp exec light -A 8 # increase screen brightness
bindsym XF86MonBrightnessDown exec light -U 8 # decrease screen brightness

# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous

include ./base16-sway/themes/base16-pico.config

# Read `man 5 sway-bar` for more information about this section.
# bar {
#     swaybar_command waybar
# }
bar {
    swaybar_command waybar
  # status_command i3blocks
	tray_output primary

  # status_command i3blocks | i3status-taskwarrior
	status_command i3status | i3status-taskwarrior
  # colors {
  #   separator #666666
  #   background #000000
  #   statusline #ffffff
  #   focused_workspace #551a8b #551a8b #ffffff
  #   active_workspace #333333 #5f676a #ffffff
  #   inactive_workspace #000000 #000000 #888888
  #   urgent_workspace #2f343a #900000 #ffffff
  # }
    colors {
        background $base00
        separator  $base01
        statusline $base04

        # State             Border  BG      Text
        focused_workspace   $base05 $base0D $base00
        active_workspace    $base05 $base03 $base00
        inactive_workspace  $base03 $base01 $base05
        urgent_workspace    $base08 $base08 $base00
        binding_mode        $base00 $base0A $base00
    }
}

# Basic color configuration using the Base16 variables for windows and borders.
# Property Name         Border  BG      Text    Indicator Child Border
# client.focused          $base05 $base0D $base00 $base0D $base0D
# client.focused_inactive $base01 $base01 $base05 $base03 $base01
# client.unfocused        $base01 $base00 $base05 $base01 $base01
# client.urgent           $base08 $base08 $base00 $base08 $base08
# client.placeholder      $base00 $base00 $base05 $base00 $base00
# client.background       $base07
# client.background #1E272B
# client.focused #EAD49B #1E272B #EAD49B #9D6A47 #9D6A47
# client.unfocused #EAD49B #1E272B #EAD49B #78824B #78824B
# client.focused_inactive #EAD49B #1E272B #EAD49B #78824B #78824B
# client.urgent #EAD49B #1E272B #EAD49B #78824B #78824B
# client.placeholder #EAD49B #1E272B #EAD49B #78824B #78824B

 
# class                 border  bground text    indicator child_border
client.focused          #6272A4 #6272A4 #F8F8F2 #6272A4   #6272A4
client.focused_inactive #44475A #44475A #F8F8F2 #44475A   #44475A
client.unfocused        #282A36 #282A36 #BFBFBF #282A36   #282A36
client.urgent           #44475A #FF5555 #F8F8F2 #FF5555   #FF5555
client.placeholder      #282A36 #282A36 #F8F8F2 #282A36   #282A36

client.background       #F8F8F2

*/
    };


    extraConfig = "seat seat0 xcursor_theme Adwaita 24\n";
  } // (if nixosConfig.programs.sway.enable
  then {
    package = null;
  } else {
    wrapperFeatures.gtk = true ;
  });
}
