# Dotfiles

## Installation

> **IMPORTANT:** Before executing any script make sure you are in this directory. Otherwise, the scripts will delete and generate files in the directory you run them from!

### Adding a new machine

Since every machine has different configurations (e.g. number of hard drives) you will need to generate a new hardware configuration.

To do that and generate all other required files, run the `new_machine` script:

```bash
$ bash new_machine.sh
```

### Installing on an existing system

> Make sure you are using the right hardware configuration for your machine. If you haven't yet generated one, follow the steps described in [Adding a new machine](#adding-a-new-machine).

Execute the `install` script.

```bash
$ bash install.sh
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
