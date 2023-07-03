#!/bin/sh

monitor="${1}"

function get_workspaces {
  wmctrl -d \
    | awk '{ print $1 " " $2 " " $9 }' \
    | grep -v 'NSP' \
    | grep "${monitor}"
}

function create_box {
  get_workspaces | while read -r id active name; do
    name="$(printf '%s\n' "${name}")"
    class=""

    test "${active}" = "*" && class="${class:-}${class:+ }active"
    case "$(wmctrl -l | awk '{print "(" $2}' | tr '\n' ')')" in
      *"(${id})"*) class="${class:-}${class:+ }occupied";;
    esac

    if [[ "${active}" = "*" ]]; then
      printf '%s' "(button${class:+ :class '${class:-}'} :onclick 'wmctrl -s ${id}' '「${name}」')"
    else
      printf '%s' "(button${class:+ :class '${class:-}'} :onclick 'wmctrl -s ${id}' '${name}')"
    fi
  done
}

xprop -spy -root _NET_CURRENT_DESKTOP | while read -r; do
  sleep .01
  printf '%s\n' '(box :orientation "v" :class "workspaces" :space-evenly true :vexpand true '"$(create_box)"')'
done