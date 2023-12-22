{ ... }: {
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    #   do not forget to change lang in `common.nix`
    layout = "de";
    xkbVariant = "";
  };
}