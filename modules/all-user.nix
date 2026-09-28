{ ... }:

{
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
