{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };
}
