{ pkgs, config, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "console=ttyMV0,115200n8"
  ];

  users.extraUsers.root.openssh.authorizedKeys.keys = [
     "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnE3wt2x/iY57AqQWmMThUhsLq2KuYdQHsv/Twh7fadlGXGA49K9Ksu6PLJ7B8e10g4izjFIk4j9tMMZxxeOjBYcqRPLPdQLjZrxWePQ0ZYcMThaNE78YygbOJcRsSomOtu2+9XV4nkatBoFZ+YINH8L9lpOFT/8N0NSq4whdant+gr/Dd8nOpKd3ceRGwOx7FEwKeZjIM5+nrOxjZnwGTAExrYuZIsBdysc7xoCa83tRw1BO6zJLMNKugr5RR5f76fec3p7BdMgB7D3tnOp2jFBOcEG2Tw7GNO+D/2rglKDkDmTCQN9lJys8lfP4G+cGoM+uIP+OypQkuZ4xqJ7dKdSCOQ1UCuOubXd2uwqJsTrwo01lNJKkQWR66tfBqzVLxyNWUkgdGAxl0s4QSJQj8fwv7754WWf5NYKSp4TO4ZOnUtkchjwxG1jMWndMiiPxOfOrP1J1YQ4Rw1sB1/TKsMbteyUk9N/xOp2WazQW7uARpDJbbsLjhH0IA3UCSmZWnXSjSDPAqk49XsQZ52K1Po6xOhvLA7SCDWaSrx7hNUbrEPkyfi4dIMF+G3j42+wjHE7PxN7yYIlJW1TTWxc2mVvPOT6emFRCrEFgOgwXVwMqH3rt1tKwf6z5Psy0hoZmK0Rt7TtdLkDzPrSCris1wOlzCR0Bm5mQ01DDVkrq7ow== eric@chip"
  ];
}
