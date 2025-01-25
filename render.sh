#!/bin/bash

# Clean
echo "Cleaning"
rm -rf ./priv

sleep 2

Run the Gleam build
echo "Running Gleam build..."
gleam run -m build

# Check if the Gleam build succeeded
if [ $? -eq 0 ]; then
  echo "Gleam build completed successfully."
else
  echo "Gleam build failed. Exiting."
  exit 1
fi

sleep 2

echo "Building Tailwind CSS"

tailwindcss -i ./static/input.css -o ./static/custom.css --minify

# sleep 3

echo "Opening HTML"

# Get the full path to the file
FILE_PATH="$(pwd)/priv/index.html"

# Function to open the file in the default web browser
open_file() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if grep -qi microsoft /proc/version; then
      # Running in WSL
      powershell.exe start "$(wslpath -w "$FILE_PATH")"
    else
      # Native Linux
      xdg-open "$FILE_PATH" 2>/dev/null
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    open "$FILE_PATH"
  elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    start "" "$FILE_PATH"
  else
    echo "Unsupported OS"
    exit 1
  fi
}
# Run the function
open_file
