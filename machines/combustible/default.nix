{ self, ... }:
{
  imports = [
    (/. + "${self}/darwin")
  ];
}
