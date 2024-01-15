{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
    theme = {
      name = "Ayu-Dark";
      package = pkgs.ayu-theme-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
    };
  };
}