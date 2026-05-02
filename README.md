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
  /core
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
