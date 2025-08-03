{
  description = "Gleam development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs =
          nixpkgs.legacyPackages.${system};
      });

      # Shared package list
      gleamPackages = pkgs: with pkgs; [
        gleam
        erlang_27
        rebar3
      ];

      # Development-specific packages
      devPackages = pkgs: with pkgs; [
        act
        colima
      ];
    in
    {
      devShells = forAllSystems ({ pkgs }:
        {
          default = pkgs.mkShell {
            packages = (gleamPackages pkgs) ++ (devPackages pkgs)
              ++
              pkgs.lib.optionals pkgs.stdenv.isLinux (with pkgs; [
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
          nativeBuildInputs = gleamPackages pkgs;
          buildPhase = ''
            export HOME=$TMPDIR
            export XDG_CACHE_HOME=$TMPDIR/gleam-cache
            mkdir -p "$XDG_CACHE_HOME/gleam/hex/hexpm/packages"
            gleam run -m build
          '';
          installPhase = ''
            mkdir -p $out
            cp -r priv $out
          '';
        };
      });
    };
}
