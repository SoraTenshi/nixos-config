{ color-scheme, ...}:
{
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        follow = "mouse";
        alignment = "left";
        vertical_alignment = "center";
        width = 400;
        height = 500;
        offset = "50x50";
        origin = "top-right";
        transparency = 30;
        frame_color = "#${color-scheme.colors.base05}";
        scale = 0;
        font = "Lilex Nerd Font Mono 11";
        
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        
        seperator_color = "frame";
        sort = "yes";
        startup_notification = true;
      };
      
      urgency_normal = {
        background = "#${color-scheme.colors.base00}";
        foreground = "#${color-scheme.colors.base05}";
        timeout = 7;
      };
    };
  };
}
