{
  description = "Gleam development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forAllSystems ({ pkgs }:
        let
          layoutFile = pkgs.writeText "layout.kdl" ''
            layout {
              pane split_direction="horizontal" {
                  pane {
                    command "hx"
                    args "."
                  }
                  pane size="20%"
              }
            }
          '';
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs;
              [
                gleam
                erlang_27
                rebar3
                flyctl
                tailwindcss
                tailwindcss-language-server
                mermaid-cli
              ]
              ++ (if pkgs.stdenv.isLinux then [ inotify-tools ] else [ ]);
            shellHook = ''
              if [ -z "$ZELLIJ" ] || [ "$ZELLIJ" -ne 0 ]; then
                zellij -l ${layoutFile}
              fi
            '';
          };
        });

      apps = forAllSystems ({ pkgs }: {
        render = {
          type = "app";
          program = toString (pkgs.writeScript "render" ''
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
          '');
        };
      });
    };
}
