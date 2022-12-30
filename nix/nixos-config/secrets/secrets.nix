let
  systems = {
    pidrive = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILM3yRVHRraaQv8/zQACUX9+XZgOZSEI+7CozjFOb0Av";
    whitecanyon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0ioOOvG8RSBl0losaQnTn1BL8nnTQeQ/SyEDe1ntOR";
    chip = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT816z8Zjx5kbIfu2nM5cAxXN7hHOMC3b0dje78lYI6";
  };

  users = {
    eric = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnE3wt2x/iY57AqQWmMThUhsLq2KuYdQHsv/Twh7fadlGXGA49K9Ksu6PLJ7B8e10g4izjFIk4j9tMMZxxeOjBYcqRPLPdQLjZrxWePQ0ZYcMThaNE78YygbOJcRsSomOtu2+9XV4nkatBoFZ+YINH8L9lpOFT/8N0NSq4whdant+gr/Dd8nOpKd3ceRGwOx7FEwKeZjIM5+nrOxjZnwGTAExrYuZIsBdysc7xoCa83tRw1BO6zJLMNKugr5RR5f76fec3p7BdMgB7D3tnOp2jFBOcEG2Tw7GNO+D/2rglKDkDmTCQN9lJys8lfP4G+cGoM+uIP+OypQkuZ4xqJ7dKdSCOQ1UCuOubXd2uwqJsTrwo01lNJKkQWR66tfBqzVLxyNWUkgdGAxl0s4QSJQj8fwv7754WWf5NYKSp4TO4ZOnUtkchjwxG1jMWndMiiPxOfOrP1J1YQ4Rw1sB1/TKsMbteyUk9N/xOp2WazQW7uARpDJbbsLjhH0IA3UCSmZWnXSjSDPAqk49XsQZ52K1Po6xOhvLA7SCDWaSrx7hNUbrEPkyfi4dIMF+G3j42+wjHE7PxN7yYIlJW1TTWxc2mVvPOT6emFRCrEFgOgwXVwMqH3rt1tKwf6z5Psy0hoZmK0Rt7TtdLkDzPrSCris1wOlzCR0Bm5mQ01DDVkrq7ow==";
  };
in {
  "pidrive/ddclient.conf.age".publicKeys = [ systems.pidrive ] ++ builtins.attrValues users;
  "whitecanyon/hostapd.conf.age".publicKeys = [ systems.whitecanyon ] ++ builtins.attrValues users;
}
