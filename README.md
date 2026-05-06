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
