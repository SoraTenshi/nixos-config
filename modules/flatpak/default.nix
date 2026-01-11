{ pkgs, isHardwareMachine, ... }:
let
  portal = (if isHardwareMachine then pkgs.xdg-desktop-portal-hyprland else pkgs.xdg-desktop-portal-xapp);
in
{
  xdg.portal = {
    enable = true;
    extraPortals = [ portal ];
  };
  environment.systemPackages = [ pkgs.flatpak ];
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    update = {
      auto.enable = true;
      onActivation = true;
    };
    packages = [
      "app.zen_browser.zen"
    ];
  };
}
