# Useful Scripts

A collection of handy scripts designed to simplify common tasks on Unix-like systems.

---

## Contents

- [Overview](#overview)
- [Script: rename_three_segment_files.sh](#script-rename_three_segment_filessh)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
  - [Example](#example)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Overview

The **Useful Scripts** project contains various scripts that automate and simplify routine tasks.

---

## Script: rename_three_segment_files.sh

### Description

The `rename_three_segment_files.sh` script searches recursively within a given directory for files whose names match the pattern:

```
stringA.stringB.stringC
```

where:

- `stringA`, `stringB`, and `stringC` are non-empty strings.
- None of the strings contain a period (`.`).

When such a file is found, the script renames it to:

```
stringA.stringC
```

effectively removing the middle segment (`stringB`) from the file name.

### Prerequisites

- **Bash Shell:** The script is written for the Bash shell.
- **Unix-like Operating System:** Such as Linux or macOS.
- **Basic Command Line Knowledge:** Familiarity with navigating directories and executing scripts.

### Usage

1. **Clone or Download the Repository:**

   ```bash
   git clone https://github.com/Rfluid/useful-scripts.git
   ```

   or download the repository as a ZIP file and extract it.

2. **Navigate to the Project Directory:**

   ```bash
   cd useful-scripts
   ```

3. **Make the Script Executable:**

   ```bash
   chmod +x bash/rename_three_segment_files.sh
   ```

4. **Run the Script:**

   ```bash
   ./bash/rename_three_segment_files.sh /path/to/target/directory
   ```

   Replace `/path/to/target/directory` with the actual path to the directory containing the files you want to process.

### Example

Suppose you have a file named:

```
example.backup.txt
```

located in `/data/files`, and it matches the pattern `stringA.stringB.stringC` where:

- `stringA` is `example`
- `stringB` is `backup`
- `stringC` is `txt`

Running the script:

```bash
./bash/rename_three_segment_files.sh /data/files
```

will rename the file to:

```
example.txt
```

**Note:** The file is only renamed if it exactly matches the pattern, and none of the segments are empty or contain a dot.

---

## Contributing

Contributions are welcome! If you have ideas for additional scripts or improvements to the existing ones, feel free to:

- Open an issue with your suggestions.
- Submit a pull request with your enhancements.

Please follow the repository's coding and contribution guidelines when making changes.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

For any questions or support, please open an issue in the repository or contact the project maintainers.

Happy scripting!
