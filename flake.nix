{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    {
      devShells =
        let
          lib = nixpkgs.lib;
          systems = [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ];
          projectName = "website";
        in
        lib.genAttrs systems (
          system:
          let
            pkgs = import nixpkgs { inherit system; };
          in
          {
            default = pkgs.mkShell {
              packages =
                with pkgs;
                [
                  gleam
                  erlang_27
                  rebar3
                  flyctl
                  tailwindcss
                  tailwindcss-language-server
                ]
                ++ (if pkgs.stdenv.isLinux then [ inotify-tools ] else [ ]);

              shellHook = ''
                if ! ps aux | grep -q '[z]ellij'; then
                  if zellij ls -n 2>&1 | grep -E '^${projectName} .*EXITED' >/dev/null; then
                    # zellij delete-session ${projectName} # delete dead session
                    echo "delete"
                  fi

                  if zellij ls -n 2>&1 | grep -E '^${projectName} ' >/dev/null; then
                    echo "attaching"
                    # zellij attach ${projectName}
                  else
                    echo "creating"
                    # zellij --session ${projectName} --new-session-with-layout layout.kdl
                  fi
                fi
              '';
            };
          }
        );
    };
}
