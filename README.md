# Dotfiles

## Installation

1. Navigate to this directory:

```bash
$ cd /path/to/dotfiles
```

2. Execute the `install.sh` script.

```bash
$ bash ./install.sh
```

This script will then ask you multiple questions to generate and install your system.

## The `userdata.nix` file

For a full example of such file see [./userdata.nix](./userdata.nix)

### About the `host`, `desktop_environment` and `rice` fields

1. The install script will override these fields, even if they are not set.
2. All valid options for these fields are displayed in the install script.

### Table

| Field | Required | Description |
|-------|----------|-------------|
| user | &check; | Your username |
| host | &cross; | The host to use and the name of the machine. |
| desktop_environment | &cross; | The desktop environment or window manager to use. |
| rice | &cross; | The rice or theme of that desktop environment or window manager. See <https://www.reddit.com/r/unixporn/> for examples of `rices`. |
