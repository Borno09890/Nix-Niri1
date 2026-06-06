{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.conf = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.hardware
      self.nixosModules.hyprland
    ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.hostName = "nix";
    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Dhaka";
    services.xserver.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
    nix.settings.experimental-features = ["nix-command" "flakes"];
    services.libinput.enable = true;
    users.users.alice = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      packages = with pkgs; [
        tree
      ];
    };
    environment.systemPackages = with pkgs; [
      neovim
      wget
      vscodium-fhs
      brave
      walker
      elephant
    ];
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.elephant.enable = true;
    services.openssh.enable = true;
    system.stateVersion = "26.05";
  };
}
