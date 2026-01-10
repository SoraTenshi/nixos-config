{ pkgs, username, ... }: {
  # flatpak stuff
  xdg.systemDirs.data = [ "/home/${username}/.local/share/flatpak/exports/share" ];

  home.packages = [ pkgs.flatpak ];
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
