_: {
  virtualisation = {
    # lxd.enable = true;
    waydroid.enable = false;
  };

  # TODO: In future add the waydroid-helper script here

  # Getting started:
  # `sudo waydroid init -s GAPPS`

  # control:
  # `waydroid session start`
  # `waydroid session stop`
  # `waydroid show-full-ui`

  # Good as well (for 1920x1080):
  # `waydroid prop set waydroid.persist.width 1920`
  # `waydroid prop set waydroid.persist.height 1050` # play around with value

  # https://github.com/casualsnek/waydroid_script
  # libndk / libhoudini for arm translation

  # Launching BA requires another fix:
  # see:
  # libhoudini: https://github.com/waydroid/waydroid/issues/788#issuecomment-2162386712
  # libndk: https://github.com/waydroid/waydroid/issues/788#issuecomment-2167334937

  # then it should work.
  # Worked for me at least XD
}
