{ pkgs, ... }: {
  home.packages = with pkgs; [
    fuzzel

    # screenshot stuff
    grim
    slurp

    wayshot
    waylock
    wlr-randr
    wofi
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          # "eDP-1"
          "DP-1"
          "DP-3"
          "HDMI-A-1"
        ];
        modules-left = [ "clock" ];
        modules-center = [ "river/tags" ];
        modules-right = [ "network" "cpu" "memory" "temperature" "battery" ];

        clock = {
          format = "{:%a | 年%Y 月%m 日%d %T}";
          interval = 1;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-alt = "{time}";
          format-full = "";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          min-length = 25;
          interval = 1;
          format-wifi = "﬉ {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "Disconnected";
          format-alt = " {bandwidthUpBytes}   {bandwidthDownBytes}";
          tooltip = true;
        };

        cpu = {
          format = "﬙{usage:2}%";
          interval = 1;
          states = {
            warning = 50;
            critical = 90;
          };
          tooltip = false;
        };

        memory = {
          format = " {}%";
          interval = 1;
          states = {
            warning = 50;
            critical = 90;
          };
          tooltip = false;
        };

        temperature = {
          format = " {temperatureC}°C";
          interval = 1;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 75;
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        border-radius: 0;
        font-family: Lilex Light Nerd Font Mono;
        min-height: 0;
      }

      window#waybar {
        background-color: #24283b;
      }

      #tags {
        font-size: 1.3rem;
        margin-bottom: 4px;
        background-color: #24283b; /*base02*/
        border: 2px solid #8031ca; /*base1*/
      }

      #tags button {
        color: #a9b1d6;
        border: 2px solid #24283b;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #tags button:hover {
        box-shadow: inherit;
        background: #8031ca; /*base02*/
        color: #7dcfff;
      }

      #tags button.focused {
        color: #a9b1d6; /*base02*/
        background-color: #8031ca; /*base1*/
        border: 2px solid #24283b; /*base02*/
      }

      #tags button.occupied {
        border: 2px solid #8031ca; /*base1*/
      }

      #tags button.urgent {
        border: 2px solid #f7768e; /*red*/
      }

      #tags button.occupied.urgent {
        border: 2px solid #f7768e; /*red*/
      }

      #tags button.focused.occupied {
        color: #24283b; /*base02*/
        background-color: #8031ca; /*base1*/
        border: 2px solid #8031ca; /*base1*/
      }

      #clock,
      #mode,
      #cpu,
      #memory,
      #battery,
      #temperature {
        padding: 8px;
        margin-left: 8px;
        margin-bottom: 4px;
        background-color: #24283b; /*base02*/
        color: #a9b1d6; /*base1*/
        border: 2px solid #8031ca; /*base1*/
      }

      #network {
        padding: 8px;
        margin-left: 8px;
        margin-bottom: 4px;
        background-color: #24283b; /*base02*/
        color: #a9b1d6; /*base1*/
        border: 2px solid #8031ca; /*base1*/
      }

      #network button {
        color: #a9b1d6;
        border: 2px solid #24283b;
      }

      #network button:hover {
        box-shadow: inherit;
        background: #8031ca;
        color: #7dcfff;
      }

      #clock {
        padding: 8px;
        margin-left: 0px;
        font-size: 1.3rem;
        margin-bottom: 4px;
      }

      #cpu.warning,
      #memory.warning {
        border: 2px solid #b58900; /*yellow*/
      }

      #cpu.critical,
      #memory.critical,
      #temperature.critical {
        border: 2px solid #dc322f; /*red*/
      }
    '';
  };

  xdg.configFile = {
    "river/init" = {
      executable = true;
      source = ./init;
    };
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
    # TODO: Migrate to base16 & nix-colors
    "fuzzel/fuzzel.ini" = {
      text = ''
        font='Lilex Nerd Font Mono-16'
        prompt='->'

        [dmenu]
        mode=text

        [colors]
        background=24283bff
        text=a9b1d6ff
        match=8031caff
        selection=8031caff
        selection-text=7aa2f7ff
        selection-match=2ac3deff
        border=8031caff

        [border]
        width=2
        radius=0
      '';
    };
  };
}
