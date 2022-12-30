# Eric Drechsel's NixOS configs

Configurations for my [NixOS](https://nixos.org/) systems.


## Fresh install from Live USB:

- `nixos-generate-config --root /mnt`
- Check out this repo to `/mnt/etc/nixos`
- `nixos-install --flake /mnt/etc/nixos#chip`


------


Having watched NixOS come together from my aging Arch install and mess
of Debian servers for several years, I\'m finally making the jump!




# Tasks

## PROJ Linux doesn\'t achieve low power states due to PCI devices

### [How to achieve S0ix states in Linux\* \| 01.org](https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux)

### PCI PM Logging! <https://www.kernel.org/doc/html/latest/firmware-guide/acpi/lpit.html>

    Also suggest check PCI device D3 status:
    Below are the commands:
    echo -n "file pci-driver.c +p" > /sys/kernel/debug/dynamic_debug/control
    echo N > /sys/module/printk/parameters/console_suspend
    echo 1 > /sys/power/pm_debug_message
    turbostat -o tc.out rtcwake -m freeze -s 60
    after resume back, check turbostat log: tc.log and dmesg log: dmesg | grep "PCI PM"

    [55342.304201] PM: suspend entry (s2idle)
    [55345.364244] nvme 0000:3c:00.0: PCI PM: Suspend power state: D0
    [55345.364249] nvme 0000:3c:00.0: PCI PM: Skipped
    [55345.365217] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
    [55345.365219] i801_smbus 0000:00:1f.4: PCI PM: Skipped
    [55345.366742] pcieport 0000:00:1d.0: PCI PM: Suspend power state: D0
    [55345.366744] pcieport 0000:00:1d.0: PCI PM: Skipped
    [55345.366812] pcieport 0000:00:1c.0: PCI PM: Suspend power state: D0
    [55345.366813] pcieport 0000:00:1c.0: PCI PM: Skipped
    [55345.376035] snd_hda_intel 0000:00:1f.3: PCI PM: Suspend power state: D3hot
    [55345.376057] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
    [55345.382533] intel_pch_thermal 0000:00:14.2: PCI PM: Suspend power state: D3hot
    [55345.382534] proc_thermal 0000:00:04.0: PCI PM: Suspend power state: D3hot
    [55345.382677] iwlwifi 0000:3a:00.0: PCI PM: Suspend power state: D3hot
    [55345.382937] rtsx_pci 0000:3b:00.0: PCI PM: Suspend power state: D3hot
    [55345.382944] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
    [55345.384092] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
    [55345.384181] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
    [55345.399197] pcieport 0000:00:1c.5: PCI PM: Suspend power state: D3hot
    [55345.399198] pcieport 0000:00:1c.4: PCI PM: Suspend power state: D3hot
    [55345.399316] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
    [55358.059082] PM: suspend exit

[211879 -- S0ix: Unable to achieve S0ix on Dell XPS 13
9310](https://bugzilla.kernel.org/show_bug.cgi?id=211879#c16)

### [199689 -- s2idle does not work in Dell XPS 9370](https://bugzilla.kernel.org/show_bug.cgi?id=199689)

## [TODO]{.todo .TODO} Org capture from browser, graphical shell {#org-capture-from-browser-graphical-shell}

Org-protocol is one route:

-   [org-protocol.el -- Intercept calls from emacsclient to trigger
    custom
    actions](https://orgmode.org/worg/org-contrib/org-protocol.html#orgcb5ca9d)

## [DONE]{.done .DONE} Managing secrets {#managing-secrets}

### Read this: [Encrypted Secrets with NixOS - Christine Dodrill](https://christine.website/blog/nixos-encrypted-secrets-2021-01-20)

### Eval:

1.  NO [Mic92/sops-nix: Atomic secret provisioning for NixOS based on
    sops](https://github.com/Mic92/sops-nix)

    -   [x] flakes support

2.  YES <https://github.com/ryantm/agenix>

    -   simpler (interface is just nix expressions, no filesystem)

3.  [nixos/security.gnupg: provisioning GnuPG-protected secrets through
    the Nix store by ju1m · Pull Request #93659 ·
    NixOS/nixpkgs](https://github.com/NixOS/nixpkgs/pull/93659)

## [TODO]{.todo .TODO} Basic home-manager config for arch {#basic-home-manager-config-for-arch}

Just so I know how to use it, for future systems [Home-Manager with
flakes on non NixOS system :
NixOS](https://www.reddit.com/r/NixOS/comments/iogoox/homemanager_with_flakes_on_non_nixos_system/)

## [TODO]{.todo .TODO} \[#C\] Install emacs in arch via hm {#c-install-emacs-in-arch-via-hm}

[Managing Emacs with NixOS and Home-Manager :
NixOS](https://www.reddit.com/r/NixOS/comments/earwda/managing_emacs_with_nixos_and_homemanager/)
[system/emacs.nix at master ·
willbush/system](https://github.com/willbush/system/blob/master/users/profiles/emacs.nix)
[user/emacs.nix · d6dcf6480e29588fd473bd5906cd226b49944019 · Robert
Helgesson / configurations ·
GitLab](https://gitlab.com/rycee/configurations/blob/d6dcf6480e29588fd473bd5906cd226b49944019/user/emacs.nix)
[nix-community/emacs-overlay: Bleeding edge emacs overlay
\[maintainer=@adisbladis](https://github.com/nix-community/emacs-overlay)\]
[nix-community \| Cachix](https://app.cachix.org/cache/nix-community)

## Graphical env

### sway {#sway id="85f4f8fc-e3dd-498f-bcba-a194b67e3ba0"}

<https://github.com/divnix/devos/blob/community/profiles/graphical/sway/default.nix>

### [davidbrazdil/volnoti: Lightweight volume notification for Linux](https://github.com/davidbrazdil/volnoti)
