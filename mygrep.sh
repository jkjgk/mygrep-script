#!/bin/bash

# Function to display help message
show_help() {
  echo "Usage: $0 [-n] [-v] search_string filename"
  echo
  echo "Options:"
  echo "  -n        Show line numbers for matching lines"
  echo "  -v        Invert the match (show lines that do NOT match)"
  echo "  --help    Display this help message"
  echo
  echo "Description:"
  echo "  This script mimics the behavior of the 'grep' command."
  echo "  It searches for a string in a file and prints matching lines."
  echo "  It supports two options:"
  echo "    -n    Show the line number where the match was found."
  echo "    -v    Invert the match: Show lines that do not match the search string."
  echo "  If no options are provided, the script will just search and print matching lines."
}

# Check if the user wants the help message
if [[ "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Default flags
SHOW_LINE_NUMBERS=false
INVERT_MATCH=false

# Read options (-n, -v)
while getopts "nv" opt; do
  case "$opt" in
    n) SHOW_LINE_NUMBERS=true ;;
    v) INVERT_MATCH=true ;;
    \?) echo "Usage: $0 [-n] [-v] search_string filename"; exit 1 ;;
  esac
done

# Shift to get the actual search string and file
shift $((OPTIND-1))

# Check if search string and file are provided
if [[ -z "$1" || -z "$2" ]]; then
  echo "Error: Missing search string or filename."
  exit 1
fi

SEARCH_STRING="$1"
FILE="$2"

# Now perform the search, either with or without inversion
line_number=0
while IFS= read -r line; do
  line_number=$((line_number + 1))

  # Check if the line contains the search string
  if [[ " ${line,,} " == *" ${SEARCH_STRING,,} "* ]]; then
    MATCHED=true
  else
    MATCHED=false
  fi

  # If we have -v (invert match), we want to print lines that don't match
  if $INVERT_MATCH; then
    if ! $MATCHED; then
      if $SHOW_LINE_NUMBERS; then
        echo "$line_number: $line"
      else
        echo "$line"
      fi
    fi
  else
    if $MATCHED; then
      if $SHOW_LINE_NUMBERS; then
        echo "$line_number: $line"
      else
        echo "$line"
      fi
    fi
  fi
done < "$FILE"

