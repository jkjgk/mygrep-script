# MyGrep Script

##  Overview

This project is a simple Bash script (`mygrep.sh`) that mimics the basic behavior of the `grep` command without using `grep` internally.  
It allows users to search for a string in a file, with options to show line numbers and invert the match.

## Features

- **Basic search**: Search for a string inside a text file.
- **Case-insensitive**: Search is not sensitive to upper or lower case.
- **Options supported**:
  - `-n` : Show line numbers for matching lines.
  - `-v` : Invert match, show lines that do not contain the search string.
  - `-nv` or `-vn` : Support combined options.
  - `--help` : Display usage instructions.

## Technologies and Commands Used

| Tool / Feature | Why Used |
| :------------- | :------- |
| **Bash scripting** | To automate the task inside a `.sh` script. |
| **`getopts`** | To handle command-line options (`-n`, `-v`) easily and flexibly. |
| **`while read` loop** | To read the file line by line manually without using `grep`. |
| **String pattern matching (`[[ $line == *$SEARCH_STRING* ]]`)** | To check manually if a line contains the search string. |
| **`shift` command** | To adjust the command-line arguments after processing options. |
| **Error handling (`if` conditions)** | To make sure the user provides correct inputs (search string and filename). |
| **Custom `--help` option** | To show a friendly usage guide for the user. |

## How Matching Works

The script reads each line of the file:
- If the line contains the **search string**, it is printed (or skipped if `-v` is used).
- The comparison is **manual** (no `grep`, `awk`, etc).
- The `-n` option prints the line number before the matched line.

## How to Run

Make the script executable:
```bash
chmod +x mygrep.sh
