# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ ../../mixins/base.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./router.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "whitecanyon"; # Define your hostname.
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";



  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  #   firefox
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  users.users.root = {
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnE3wt2x/iY57AqQWmMThUhsLq2KuYdQHsv/Twh7fadlGXGA49K9Ksu6PLJ7B8e10g4izjFIk4j9tMMZxxeOjBYcqRPLPdQLjZrxWePQ0ZYcMThaNE78YygbOJcRsSomOtu2+9XV4nkatBoFZ+YINH8L9lpOFT/8N0NSq4whdant+gr/Dd8nOpKd3ceRGwOx7FEwKeZjIM5+nrOxjZnwGTAExrYuZIsBdysc7xoCa83tRw1BO6zJLMNKugr5RR5f76fec3p7BdMgB7D3tnOp2jFBOcEG2Tw7GNO+D/2rglKDkDmTCQN9lJys8lfP4G+cGoM+uIP+OypQkuZ4xqJ7dKdSCOQ1UCuOubXd2uwqJsTrwo01lNJKkQWR66tfBqzVLxyNWUkgdGAxl0s4QSJQj8fwv7754WWf5NYKSp4TO4ZOnUtkchjwxG1jMWndMiiPxOfOrP1J1YQ4Rw1sB1/TKsMbteyUk9N/xOp2WazQW7uARpDJbbsLjhH0IA3UCSmZWnXSjSDPAqk49XsQZ52K1Po6xOhvLA7SCDWaSrx7hNUbrEPkyfi4dIMF+G3j42+wjHE7PxN7yYIlJW1TTWxc2mVvPOT6emFRCrEFgOgwXVwMqH3rt1tKwf6z5Psy0hoZmK0Rt7TtdLkDzPrSCris1wOlzCR0Bm5mQ01DDVkrq7ow== eric@chip"];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?

}

