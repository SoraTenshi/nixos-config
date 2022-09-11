#!/bin/sh

function get_time {
  date '+%T' | 
    sed "s/:/ /g"
}

for (( ; ; )); do
  sleep 1
  get_time | while read -r hh mm ss; do
    printf '%s\n' '(box :orientation "v" :class "hours"   :space-evenly true :vexpand true :content '"時${hh}"')'
    printf '%s\n' '(box :orientation "v" :class "minutes" :space-evenly true :vexpand true :content '"分${mm}"')'
    printf '%s\n' '(box :orientation "v" :class "seconds" :space-evenly true :vexpand true :content '"秒${ss}"')'
  done
done