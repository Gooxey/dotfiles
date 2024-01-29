{ pkgs, ... }: {
    home.packages = [ pkgs.git ];
    programs.git = {
        enable = true;
        userEmail = "dennis.tiderko@gmail.com";
        userName = "Gooxey";
    };
}