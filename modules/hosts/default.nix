{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.borno = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.conf
    ];
  };
}
