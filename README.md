---
# Useful Scripts

A collection of handy scripts designed to simplify common tasks on Unix‑like systems.
---

## Contents

- [Overview](#overview)
- [Script: rename_three_segment_files.sh](#script-rename_three_segment_filessh)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
  - [Example](#example)
- [Script: create-compose-launcher.sh](#script-create-compose-launchersh)
  - [Description](#description-1)
  - [Prerequisites](#prerequisites-1)
  - [Usage](#usage-1)
  - [Example](#example-1)
  - [Optional Flags](#optional-flags)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Overview

The **Useful Scripts** project contains various Bash helpers that automate and simplify routine tasks such as batch‑renaming files or turning a Docker‑Compose stack into a normal KDE launcher. All scripts live in the `bash/` directory.

---

## Script: rename_three_segment_files.sh

### Description

`rename_three_segment_files.sh` searches recursively within a given directory for files whose names match the pattern:

```
stringA.stringB.stringC
```

where:

- `stringA`, `stringB`, and `stringC` are non‑empty strings.
- None of the strings contain a period (`.`).

When such a file is found, the script renames it to:

```
stringA.stringC
```

effectively removing the middle segment (`stringB`) from the file name.

### Prerequisites

- **Bash Shell** (tested on Bash 5+).
- **Unix‑like Operating System** (Linux or macOS).
- **Basic Command‑Line Knowledge** for navigating directories and executing scripts.

### Usage

```bash
# 1 Clone or download the repository
$ git clone https://github.com/Rfluid/useful-scripts.git
$ cd useful-scripts

# 2 Make the script executable (only once)
$ chmod +x bash/rename_three_segment_files.sh

# 3 Run the script on a target directory
$ ./bash/rename_three_segment_files.sh /path/to/target/directory
```

### Example

Suppose a file named `example.backup.txt` resides in `/data/files`.

```bash
./bash/rename_three_segment_files.sh /data/files
```

The file is renamed to `example.txt` because `backup` (the middle segment) is removed.

---

## Script: create-compose-launcher.sh

### Description

`create-compose-launcher.sh` turns any **Docker‑Compose** project into a fully‑featured KDE/Plasma launcher that:

1. Opens your default terminal emulator.
2. *cd*s to the Compose directory you specify.
3. Runs `docker compose up` **in the foreground**, streaming live logs.
4. Optionally copies the launcher to `~/.config/autostart/` for automatic start at login.

The script writes a properly formatted **`.desktop` file** into `~/.local/share/applications/`, refreshes KDE’s application cache (`kbuildsycoca5`), and prints a success message.

### Prerequisites

- **Bash Shell** (tested on Bash 5+).
- **Unix‑like Operating System** with **KDE/Plasma** (e.g., Kubuntu 22.04).
- **Docker Engine & Docker Compose v2** (`docker compose` command available).
- The `kbuildsycoca5` utility (bundled with KDE, used to refresh the menu cache).

### Usage

```bash
# 1 Clone or download the repository
$ git clone https://github.com/Rfluid/useful-scripts.git
$ cd useful-scripts

# 2 Make the script executable (only once)
$ chmod +x bash/create-compose-launcher.sh

# 3 Generate a launcher for your Compose project
$ ./bash/create-compose-launcher.sh \
      -n "My App" \
      -d /absolute/path/to/compose-folder \
      -i /absolute/path/to/icon.svg
```

Arguments:

| Flag | Required | Description                                             |
| ---- | -------- | ------------------------------------------------------- |
| `-n` | yes      | Human‑readable **name** that appears in the KDE menu.   |
| `-d` | yes      | Absolute path to the **Docker‑Compose folder**.         |
| `-i` | yes      | Absolute path to an **icon** (`.png` or `.svg`).        |
| `-c` | no       | Comma‑separated KDE **Categories** (default `Utility`). |
| `-f` | no       | **Force‑overwrite** an existing `.desktop` file.        |
| `-a` | no       | Also copy the launcher to `~/.config/autostart/`.       |

### Example

```bash
$ ./bash/create-compose-launcher.sh \
      -n "Personal Blog" \
      -d ~/projects/blog-stack \
      -i ~/Pictures/blog.svg \
      -a
```

The command creates:

- `~/.local/share/applications/personal-blog.desktop` — the launcher.
- `~/.config/autostart/personal-blog.desktop` — autostarts at login (because `-a` was used).

After the script finishes, search **“Personal Blog”** in Kickoff and click it. A terminal opens, `docker compose up` starts in the foreground, and the container logs stream live until you hit **Ctrl +C** or close the window.

### Optional Flags

| Flag                     | Effect                                                                                                |
| ------------------------ | ----------------------------------------------------------------------------------------------------- |
| `-c Development;Docker;` | Changes the KDE category for easier menu sorting.                                                     |
| `-f`                     | Overwrites any existing launcher with the same slug (lower‑case, hyphenated version of the app name). |
| `-a`                     | Places a copy in `~/.config/autostart/` so the stack starts automatically at login.                   |

---

## Contributing

Contributions are welcome! If you have ideas for additional scripts or improvements to existing ones, feel free to:

1. **Open an issue** with your suggestions.
2. **Submit a pull request** with your enhancements.

Please follow the repository’s coding and contribution guidelines when making changes.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

For any questions or support, please open an issue in the repository or contact the project maintainers.

Happy scripting!

---
