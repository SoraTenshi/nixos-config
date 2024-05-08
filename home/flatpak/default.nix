_: {
  services.flatpak = {
    enable = true;
    update.auto.enable = true;
    remotes = [{
      name = "flathub"; # beta!!!
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];

    packages = [{
      appId = "com.discordapp.Discord";
      origin = "flathub";
    }];
  };
}
