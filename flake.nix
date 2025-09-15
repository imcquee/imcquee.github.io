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
        bun
        nodejs
        cacert
      ];
      # Development-specific packages
      devPackages = pkgs: with pkgs; [
        act
        colima
        tailwindcss-language-server
        vscode-langservers-extracted
        typescript-language-server
        codebook
        ffmpeg
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
          };
        });
      packages = forAllSystems ({ pkgs }: {
        default = pkgs.stdenv.mkDerivation {
          pname = "website";
          version = "1.0.0";
          src = ./.;
          nativeBuildInputs = (gleamPackages pkgs);
          DOCKER_HOST = "unix:///Users/imcquee/.config/colima/default/docker.sock";
          SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          SSL_CERT_DIR = "${pkgs.cacert}/etc/ssl/certs";
          NODE_EXTRA_CA_CERTS = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          BUILD_ENV = "production";
          NODE_ENV = "production";
          CSS_INPUT = "website.css";
          CSS_OUTPUT = "output.css";
          POST_DIR = "./posts";
          STATIC_DIR = "./static";
          OUT_DIR = "./priv";
          COMPONENTS_DIR = "./src/components";
          SRC_DIR = "./src";
          DEV_DIR = "./.dev";
          buildPhase = ''
            export HOME=$TMPDIR
            export XDG_CACHE_HOME=$TMPDIR/gleam-cache
            mkdir -p "$XDG_CACHE_HOME/gleam/hex/hexpm/packages"
            gleam run -m esgleam/install
            gleam run -m build
            bun i
            bun run scripts/shiki.ts
            tailwindcss -i ./website.css -o ./priv/output.css --minify
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
