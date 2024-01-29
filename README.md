# Dotfiles

## Scripts

> **WARNING:** Every script is meant to be executed from the same directory the script is in. Executing any script from outside their directory may result in unintended behavior!

Just run the master script which will guide you through all available options.

```bash
# Remember the warning above!
bash ./RUNME.sh
```

## The `userdata.nix` file

For a full example of such file see [./userdata.nix](./userdata.nix)

### About the `host`, `desktop_environment` and `rice` fields

1. The rebuild / master script will override these fields, even if they are not set.
2. All valid options for these fields are displayed in the install script.

### Table

| Field | Required | Description |
|-------|----------|-------------|
| user | &check; | Your username |
| host | &cross; | The host to use and the name of the machine. |
| desktop_environment | &cross; | The desktop environment or window manager to use. |
| rice | &cross; | The rice or theme of that desktop environment or window manager. See <https://www.reddit.com/r/unixporn/> for examples of `rices`. |
