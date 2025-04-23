#!/usr/bin/env bash
#
# create-compose-launcher.sh
#
# Quickly generate a .desktop launcher that
#  ▸ opens your default terminal
#  ▸ cd’s to a Compose directory
#  ▸ runs `docker compose up` **in the foreground**
#
# Tested on Kubuntu 22.04 / Plasma 5.27
#
# ────────────────────────────────────────────────────────────
# Usage:
#   ./create-compose-launcher.sh -n "My App" \
#                                -d /abs/path/to/compose \
#                                -i /abs/path/to/icon.svg
#
# Optional flags
#   -c Utility        Comma‑separated Categories= (default Utility)
#   -f                Force‑overwrite an existing .desktop file
#   -a                Also copy the launcher to ~/.config/autostart/
#
# Result:
#   ~/.local/share/applications/my-app.desktop  (and maybe autostart copy)
#   The system menu appears after   kbuildsycoca5   or a log‑out/in.
# ────────────────────────────────────────────────────────────

set -euo pipefail

# ─────────── helper: show usage and exit ───────────
usage() {
    grep -E '^#' "$0" | cut -c3-
    exit "${1:-0}"
}

# ─────────── parse CLI options ───────────
force_overwrite=false
autostart=false
categories="Utility"

while getopts "n:d:i:c:fa?h" opt; do
    case "$opt" in
    n) app_name=$OPTARG ;;
    d) compose_dir=$(realpath -m "$OPTARG") ;;
    i) icon_path=$(realpath -m "$OPTARG") ;;
    c) categories=$OPTARG ;;
    f) force_overwrite=true ;;
    a) autostart=true ;;
    h | ?) usage ;;
    esac
done

# ─────────── validate required args ───────────
for var in app_name compose_dir icon_path; do
    [[ -v $var ]] || {
        echo "Error: -${var:0:1} is required"
        usage 1
    }
done
[[ -d $compose_dir ]] || {
    echo "Error: compose directory not found"
    exit 1
}
[[ -f $icon_path ]] || {
    echo "Error: icon file not found"
    exit 1
}

# ─────────── derive filenames ───────────
slug=$(echo "$app_name" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-')
desktop_dir="$HOME/.local/share/applications"
autostart_dir="$HOME/.config/autostart"
desktop_file="$desktop_dir/${slug}.desktop"

# ─────────── create .desktop entry ───────────
mkdir -p "$desktop_dir"
$force_overwrite || [[ ! -e $desktop_file ]] ||
    {
        echo "Error: $desktop_file exists (use -f to overwrite)"
        exit 1
    }

cat >"$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=${app_name} (foreground)
Comment=Run docker compose up and show live logs
Exec=bash -c 'cd ${compose_dir} && docker compose up'
Terminal=true
Icon=${icon_path}
Categories=${categories};
EOF

chmod +x "$desktop_file"

# ─────────── optional autostart copy ───────────
if $autostart; then
    mkdir -p "$autostart_dir"
    cp "$desktop_file" "$autostart_dir/"
fi

# ─────────── refresh Plasma menu ───────────
kbuildsycoca5 >/dev/null 2>&1 || true # ignore missing‑cache errors

echo "✔ Launcher created at $desktop_file"
$autostart && echo "✔ Autostart copy placed in $autostart_dir"
echo "You can now find “${app_name}” in the application launcher."
