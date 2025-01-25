#!/bin/bash

# Clean
echo "Cleaning"
rm -rf ./priv

echo "Building Tailwind CSS"

tailwindcss -i ./static/input.css -o ./static/custom.css --minify
