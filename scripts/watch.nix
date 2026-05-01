{ pkgs, user, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "${user.scriptPrefix}-watch" ''
      set -euo pipefail

      max_length=160
      max_lines=8
      show_created=false

      while [ "$#" -gt 0 ]; do
        case "$1" in
          --create)
            show_created=true
            shift
            ;;
          --length)
            if [ "$#" -lt 2 ]; then
              printf '%s\n' "length required" >&2
              exit 1
            fi

            max_length="$2"
            shift 2
            ;;
          --lines)
            if [ "$#" -lt 2 ]; then
              printf '%s\n' "lines required" >&2
              exit 1
            fi

            max_lines="$2"
            shift 2
            ;;
          *)
            break
            ;;
        esac
      done

      if [ "$#" -eq 0 ]; then
        printf '%s\n' "path(s) required" >&2
        exit 1
      fi

      paths=("$@")
      tmp=$(mktemp -d)

      trap 'rm -rf "$tmp"' EXIT

      git=(
        ${pkgs.git}/bin/git
        --no-pager
        --git-dir="$tmp"
        --work-tree=/
      )

      "''${git[@]}" init -q
      "''${git[@]}" add -f -A -- "''${paths[@]}"

      red="$(printf '\033[31m')"
      green="$(printf '\033[32m')"
      reset="$(printf '\033[0m')"

      ${pkgs.inotify-tools}/bin/inotifywait -q -m -r -e close_write,moved_to --format '%w%f' -- "''${paths[@]}" |
        while IFS= read -r file; do
          if [ ! -f "$file" ] && [ ! -L "$file" ]; then
            continue
          fi

          if ! "''${git[@]}" ls-files --error-unmatch -- "$file" >/dev/null 2>&1; then
            if [ "$show_created" = true ]; then
              printf 'created %s\n\n' "$file"
            fi

            "''${git[@]}" add -f -A -- "$file" 2>/dev/null || true
            continue
          fi

          changed=$(
            "''${git[@]}" diff --no-color --no-ext-diff --unified=0 -- "$file" |
              ${pkgs.gnused}/bin/sed -n '/^@@/,$ { /^[+-]/p }' |
              ${pkgs.gawk}/bin/awk -v red="$red" -v green="$green" -v reset="$reset" -v max_length="$max_length" -v max_lines="$max_lines" '
                {
                  line = $0

                  if (length(line) > max_length) {
                    next
                  }

                  lines[++count] = line
                }

                END {
                  if (count > max_lines) {
                    exit
                  }

                  for (i = 1; i <= count; i++) {
                    if (lines[i] ~ /^\+/) {
                      print green lines[i] reset
                    } else if (lines[i] ~ /^-/) {
                      print red lines[i] reset
                    }
                  }
                }
              ' || true
          )

          if [ -n "$changed" ]; then
            printf '%s:\n%s\n\n' "$file" "$changed"
          fi

          "''${git[@]}" add -f -A -- "$file" 2>/dev/null || true
        done
    '')
  ];
}
