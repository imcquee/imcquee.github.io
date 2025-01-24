#!/bin/bash

# Run the Gleam build
echo "Running Gleam build..."
gleam run -m build

# Check if the Gleam build succeeded
if [ $? -eq 0 ]; then
  echo "Gleam build completed successfully."
else
  echo "Gleam build failed. Exiting."
  exit 1
fi

# Run the Tailwind CSS build
echo "Building Tailwind CSS..."
tailwindcss -i ./static/input.css -o ./static/custom.css

# Check if the Tailwind CSS build succeeded
if [ $? -eq 0 ]; then
  echo "Tailwind CSS build completed successfully."
else
  echo "Tailwind CSS build failed. Exiting."
  exit 1
fi
