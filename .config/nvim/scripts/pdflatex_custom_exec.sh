#!/bin/bash

# Run pdflatex with the provided filename
pdflatex "$1"

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "LaTeX compilation successful."

    # Move misc files to 'misc' directory
    mkdir -p misc  # Create 'misc' directory if it doesn't exist

    # Move files with specified extensions
    mv *.aux *.fdb_latexmk *.fls *.log *.synctex.gz misc/

    echo "Misc files moved successfully."
else
    echo "Error compiling LaTeX."
fi

