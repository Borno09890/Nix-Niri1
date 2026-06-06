{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.hyprland = {
    pkgs,
    lib,
    ...
  }: {
    programs.hyprland = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myHyprland = inputs.wrapper-modules.wrappers.hyprland.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          # "Mod+Q".close-window = true;
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
