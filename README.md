## Installation

- Become root

  ```sh
  sudo -i
  ```

- Find disk

  ```sh
  lsblk | grep disk
  ```

- Run installer

  ```sh
  curl -fsSLo _ https://meowfeet.github.io/dotfiles/install.sh && bash _ /dev/[disk]
  ```

- Reboot

  ```sh
  reboot
  ```

---

## Structure

- Rarely changed

  ```text
  /modules
  ```

- Personal

  ```text
  /profile
  ```

- Commands

  ```text
  /scripts
  ```

- Entry point

  ```text
  /configuration.nix
  ```

---

## Keybindings

`Super` is also called the Windows/Command key.

### Core

| Keybind | Tap | Hold |
| --- | --- | --- |
| `Super` | Overview | |
| `Super+V` | Minimize window | Maximize window |
| `Super+X` | Show desktop | Close window |

### Directional

| Keybind | Tap | Hold | Alt |
| --- | --- | --- | --- |
| `Super+Z` | Switch workspace left | Move window to workspace left | Tile window left |
| `Super+C` | Switch workspace right | Move window to workspace right | Tile window right |

### Miscellaneous

| Keybind | Tap | Hold |
| --- | --- | --- |
| `Super+Enter` | Open Console | |
| `Super+I` | Open Settings | |
| `Super+L` | Lock screen | |
| `Super+Shift+S` | Screenshot active window | Screenshot UI |
