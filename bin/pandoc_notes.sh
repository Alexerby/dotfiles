#!/bin/bash

# Specify the directory where your notes are located
NOTES_DIR=~/Dropbox/notes/src

# Specify the directory to move old notes to
OLD_NOTES_DIR=~/Dropbox/notes/old_notes

# Change to the notes directory
cd "$NOTES_DIR"

# Get the date range for the notes based on creation time
START_DATE=$(stat -c %y $(ls -t note-*.md | tail -n 1) | cut -d' ' -f 1)
END_DATE=$(stat -c %y $(ls -t note-*.md | head -n 1) | cut -d' ' -f 1)

# Specify the output PDF file with the date range
OUTPUT_PDF=~/Dropbox/notes/pdf/concatenated_notes_${START_DATE}_to_${END_DATE}.pdf

# Concatenate all Markdown files into a single PDF file using pandoc
pandoc -s $(ls -t note-*.md) -o "$OUTPUT_PDF"

# Move old notes to the specified directory
mv note-*.md "$OLD_NOTES_DIR"

# Print a message indicating the process is complete
echo "Notes concatenated and saved to $OUTPUT_PDF"
echo "Old notes moved to $OLD_NOTES_DIR"

