{ pkgs, ... }: {
    home.packages = [ pkgs.vscode ];
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            asvetliakov.vscode-neovim
            tamasfe.even-better-toml
            usernamehw.errorlens
            gruntfuggly.todo-tree

            rust-lang.rust-analyzer

            jnoortheen.nix-ide
        ];
        userSettings = {
            "files.autoSave" = "afterDelay";
            "window.titleBarStyle" = "custom";
        };
    };
}