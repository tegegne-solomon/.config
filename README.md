# Dotfiles

Personal Linux configuration files, organized as [GNU Stow](https://www.gnu.org/software/stow/) packages. Each package mirrors its destination below the home directory (or, for selected system packages, below `/`).

## Included configurations

| Package | Contents |
| --- | --- |
| `alacritty` | Alacritty terminal |
| `bash` | Bash shell |
| `btop`, `htop` | System monitors |
| `fish` | Fish shell |
| `git` | Git settings |
| `hypr` | Hyprland, Hypridle, and Hyprlock |
| `keyd` | Keyboard remapping daemon |
| `kitty` | Kitty terminal |
| `ly` | Ly display manager |
| `mpd` | Music Player Daemon |
| `starship` | Starship prompt |
| `system` | Shell aliases and MIME associations |
| `waybar` | Waybar configuration and styling |
| `ytfzf` | Ytfzf |

`myshorts` contains personal reference notes and is deliberately not deployed by the setup script.

## Install

Install GNU Stow with your distribution's package manager, then clone this repository into your home directory and run:

```bash
./setup.sh
```

The script stows each configuration package into the parent directory of this repository (normally your home directory). Run it only from a clone located there, and review or back up existing configuration files first—Stow will refuse conflicting files rather than overwrite them.

Packages containing system-level paths, such as `keyd` and `ly`, may need to be stowed with an appropriate target and elevated permissions instead of using the script.

To deploy a single package manually:

```bash
stow fish
```

To remove its symlinks later:

```bash
stow -D fish
```
