{
  description = "Gleam development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
      # Shared package list
      gleamPackages = pkgs: with pkgs; [
        gleam
        erlang_28
        rebar3
        tailwindcss_4
      ];
      # Development-specific packages
      devPackages = pkgs: with pkgs; [
        act
        colima
        tailwindcss-language-server
        bun
        vscode-langservers-extracted
        typescript-language-server
        codebook
        ffmpeg
        elixir
      ];
    in
    {
      devShells = forAllSystems ({ pkgs }:
        {
          default = pkgs.mkShell {
            packages = (gleamPackages pkgs) ++ (devPackages pkgs)
              ++ pkgs.lib.optionals pkgs.stdenv.isLinux (with pkgs; [
              inotify-tools
            ]);
            shellHook = ''
              export DOCKER_HOST="unix:///Users/imcquee/.config/colima/default/docker.sock"
            '';
          };
        });
      packages = forAllSystems ({ pkgs }: {
        default = pkgs.stdenv.mkDerivation {
          pname = "website";
          version = "1.0.0";
          src = ./.;
          nativeBuildInputs = (gleamPackages pkgs) ++ [ pkgs.bun ];
          buildPhase = ''
            export HOME=$TMPDIR
            export XDG_CACHE_HOME=$TMPDIR/gleam-cache
            mkdir -p "$XDG_CACHE_HOME/gleam/hex/hexpm/packages"
            gleam run -m build
            bun run scripts/shiki.mjs
            tailwindcss -i ./static/website.css -o ./priv/output.css --minify
          '';
          installPhase = ''
            mkdir -p $out
            cp -r priv $out
          '';
        };
      });
      apps = forAllSystems ({ pkgs }: {
        develop = {
          type = "app";
          program = "${pkgs.writeShellScript "develop-website" ''
            echo "Starting development server..."
            bun i
            bun vite
          ''}";
        };
      });
    };
}
