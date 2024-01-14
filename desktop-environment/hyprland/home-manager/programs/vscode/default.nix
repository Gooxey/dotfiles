{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
    };
  };
}
