{
  lib,
  platform,
  ...
}: {
  imports =
    [
      ./aws
      ./base
      ./fish
      ./git
      ./helix
      ./kitty
      ./sops
    ]
    ++ (lib.lists.optionals (platform == "darwin") [
      ./amethyst
      ./window-management
    ]);
}
