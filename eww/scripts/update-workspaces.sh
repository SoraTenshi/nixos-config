#!/bin/sh

gib_workspace_names() {
  wmctrl -d \
    | awk '{ print $1 " " $2 " " $9 }' \
    | grep -v NSP \
    | grep "${1}_"
}

gib_workspace_yuck() {
  buffered=""
  gib_workspace_names $1 | while read -r id active name; do
    name="${name#*_}"
    if [ "$active" == '*' ]; then
      active_class="active"
    else
      active_class="inactive"
    fi

    if wmctrl -l | grep --regexp '.*\s\+'"$id"'\s\+.*' >/dev/null; then
      button_class="occupied"
      button_name=name
    else
      button_class="empty"
      button_name=name
    fi
    buffered+="(button :class \"$button_class $active_class\"  :onclick \"wmctrl -s $id\" \"$button_name\")"
    if [ $button_class = "occupied" -o $active_class = "active" ]; then
      echo -n "$buffered"
      buffered=""
    fi
  done
}


box_attrs=':orientation "v" :class "workspaces" :space-evenly true :halign "center" :valign "center" :vexpand true '

eww -c ~/.config/eww-bar update workspaces_1_yuck="(box $box_attrs $(gib_workspace_yuck 1))"
# eww -c ~/.config/eww-bar update workspaces_2_yuck="(box $box_attrs $(gib_workspace_yuck 2))"
# eww -c ~/.config/eww-bar update workspaces_3_yuck="(box $box_attrs $(gib_workspace_yuck 3))"
# eww -c ~/.config/eww-bar update workspaces_4_yuck="(box $box_attrs $(gib_workspace_yuck 4))"
# eww -c ~/.config/eww-bar update workspaces_5_yuck="(box $box_attrs $(gib_workspace_yuck 5))"
# eww -c ~/.config/eww-bar update workspaces_6_yuck="(box $box_attrs $(gib_workspace_yuck 6))"
# eww -c ~/.config/eww-bar update workspaces_7_yuck="(box $box_attrs $(gib_workspace_yuck 7))"
# eww -c ~/.config/eww-bar update workspaces_8_yuck="(box $box_attrs $(gib_workspace_yuck 8))"
# eww -c ~/.config/eww-bar update workspaces_9_yuck="(box $box_attrs $(gib_workspace_yuck 9))"
