{ inputs, pkgs, userdata, stateVersion, ... }: {
    nixpkgs.config.permittedInsecurePackages = [
        # needed because of obsidian
        "electron-25.9.0"
    ];

    # user
    users.users.${userdata.user} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
    };
    home-manager = {
        extraSpecialArgs = { inherit inputs stateVersion userdata; };
        useGlobalPkgs = true;
        useUserPackages = true;
    };

    # boot loader
    boot = {
        # latest kernel
        kernelPackages = pkgs.linuxPackages_latest;

        # no messages
        initrd.verbose = false;
        consoleLogLevel = 0;
        kernelParams = [ "quiet" "udev.log_level=0" ];

        # loading screen
        plymouth = {
            enable = true;
            theme = "bgrt";
        };

        # loader
        loader = {
            efi = {
                canTouchEfiVariables = true;
	            efiSysMountPoint = "/boot";
            };
            grub = {
                enable = true;
                devices = [ "nodev" ];
                useOSProber = true;
                efiSupport = true;
                gfxmodeBios = "1920x1080"; # resolution

                # custom theme
                theme = pkgs.stdenv.mkDerivation {
                    pname = "distro-grub-themes";
                    version = "3.1";
                    src = pkgs.fetchFromGitHub {
                        owner = "AdisonCavani";
                        repo = "distro-grub-themes";
                        rev = "v3.1";
                        hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
                    };
                    installPhase = "cp -r customize/nixos $out";
                };
            };
        };
    };

    time = {
        # language
        timeZone = "Europe/Berlin";
        # Windows compatible clock
        hardwareClockInLocalTime = true;
    };
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "de_DE.UTF-8";
            LC_IDENTIFICATION = "de_DE.UTF-8";
            LC_MEASUREMENT = "de_DE.UTF-8";
            LC_MONETARY = "de_DE.UTF-8";
            LC_NAME = "de_DE.UTF-8";
            LC_NUMERIC = "de_DE.UTF-8";
            LC_PAPER = "de_DE.UTF-8";
            LC_TELEPHONE = "de_DE.UTF-8";
            LC_TIME = "de_DE.UTF-8";
        };
    };
    # Configure console keymap
    console.keyMap = "de";

    # nix settings
    nix = {
        settings = {
            # automate `nix store --optimise`
            auto-optimise-store = true;
            experimental-features = [ "nix-command" "flakes" ];
            warn-dirty = false;

            substituters = [
                "https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
        };

        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    nixpkgs.config.allowUnfree = true;

    # automatic updates
    system = {
        inherit stateVersion;
        autoUpgrade = {
            enable = true;
            dates = "daily";
        };
    };

    # sound
    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # networking
    networking = {
        networkmanager.enable = true;
        hostName = userdata.host;
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable browsing samba shares
    services.gvfs.enable = true;
}
