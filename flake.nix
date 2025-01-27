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
                if zellij list-sessions | grep -q ${projectName}; then
                  echo "Attaching to existing Zellij session: ${projectName}"
                  zellij attach "${projectName}"
                else
                  echo "Creating new Zellij session: ${projectName}"
                  zellij --new-session-with-layout layout.kdl --session website
                fi
              '';
            };
          }
        );
    };
}
