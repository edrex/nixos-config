{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "doom_acario_dark";
      #theme = "gruvbox";
      #theme = "base16_terminal";

      editor = {
        line-number = "relative";
        mouse = true;
        indent-guides.render = true;
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        gutters = ["diagnostics" "line-numbers" "spacer"];
        true-color = true;
        lsp = {
          display-messages = true;
        };
        whitespace = {
          render.space = "all";
          render.tab = "all";
          render.newline = "all";
          characters.space = "·";
          characters.nbsp = "⍽";
          characters.tab = "→";
          characters.newline = "⏎";
          characters.tabpad = "-";
        };
      };
    };
  };
}