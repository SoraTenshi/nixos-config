{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ pavucontrol ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    extraConfig.pipewire."99-latency.tuning" = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 ];
        "default.clock.quantum" = 2048;
        "api.alsa.headroom" = 1024;
        "default.clock.min-quantum" = 48;
        "default.clock.max-quantum" = 8192;
      };
    };
  };

  # allow realtime priority for audio group
  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nice";
        type = "-";
        value = "-15";
      }
    ];
  };
}
