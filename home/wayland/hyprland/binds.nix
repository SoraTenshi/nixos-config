_:
let
  terminal = "kitty";
  other-terminal = "ghostty";
  zipWith = f: xs: ys:
    if xs == [ ] || ys == [ ] then
      [ ]
    else
      [ (f (builtins.head xs) (builtins.head ys)) ]
      ++ zipWith f (builtins.tail xs) (builtins.tail ys);

  keys = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
  workspaceChange = ws: nr:
    "SUPER, ${nr}, focusworkspaceoncurrentmonitor, ${ws}";
  workspaceMove = ws: nr:
    "SUPERSHIFT, ${nr}, movetoworkspacesilent, name:${ws}";
in {
  wayland.windowManager.hyprland.settings = {
    bindm = [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];

    bind = [
      #### Execute apps ####
      "SUPERSHIFT, D, exec, discord --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
      "SUPERSHIFT, RETURN, exec, ${terminal}"
      "SUPER, RETURN, exec, GDK_DEBUG=gl-disable-gles ${other-terminal}"
      ''
        SUPERSHIFT, P, exec, ags -r "BarState.value = 'shutdown $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"''
      # ''
      #   SUPER, X, exec, ags -r "BarState.value = 'executor $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"''
      # ''
      #   SUPER, P, exec, ags -r "BarState.value = 'app-launcher $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"
      # ''
      
      ''SUPER, X, exec, fuzzel -T "xterm -e" -p "λ " --lines 0 --line-height=40 -x 20 -y 5 -f "Lilex Nerd Font 80" -r 0''
      ''SUPER, P, exec, fuzzel -f "Lilex Nerd Font" -l 10 --line-height=32 -r 0 -w 60 --match-mode=fzf -p ">_ "''
      ''CONTROL, PRINT, exec, grim -g "$(slurp)" - | wl-copy''
      ''SHIFTCONTROL, PRINT, exec, grim -g "$(slurp)" - | swappy -f - ''
      "SUPERSHIFTCONTROL, L, exec, hyprlock"
      "SUPERSHIFTCONTROL, Q, exit"

      #### Controls ####
      "SUPERSHIFT, Q, killactive"
      "SUPER, F, fullscreen"
      "SUPER, T, togglefloating"
      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, K, movefocus, u"
      "SUPER, J, movefocus, d"
      "SUPERSHIFT, H, resizeactive, -100 0"
      "SUPERSHIFT, L, resizeactive, 100 0"
      "SUPERSHIFT, K, resizeactive, 0 100"
      "SUPERSHIFT, J, resizeactive, 0 -100"

      #### Multi Monitor stuff ####
      "SUPER, bracketleft, focusmonitor, l"
      "SUPER, bracketright, focusmonitor, r"
    ] ++
      #### Change workspace ####
      (zipWith workspaceChange keys keys) ++
      #### Move to workspace ####
      (zipWith workspaceMove keys keys);
  };
}
