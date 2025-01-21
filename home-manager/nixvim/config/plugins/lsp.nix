{
  enable = true;

  servers = {
    nixd.enable = true;
    zls.enable = true;
    pyright.enable = true;

    # c
    cmake.enable = true;
    clangd.enable = true;

    # web
    html.enable = true;
    htmx.enable = true;
  };

  keymaps.lspBuf = {
    "gd" = "definition";
    "gD" = "references";
    "gs" = "signature_help";
    "gi" = "implementation";
    "gt" = "type_definition";
    "K" = "hover";
    "<space>rn" = "rename";
    "<space>a" = "code_action";
    "<space>fm" = "format";
  };
}
