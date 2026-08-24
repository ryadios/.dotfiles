local programs = require("lua.programs")

local function start(command, rules)
  hl.exec_cmd(command, rules)
end

hl.on("hyprland.start", function()
  -- Export the Wayland session before user services and portals activate.
  start("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  start("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- Core desktop services.
  start("systemctl --user start hyprpolkitagent")
  start("hypridle")
  start("waybar")
  start("vicinae server")
  start("hyprshade auto")
  start("udiskie")
  start("mako")
  start("awww-daemon")
  start("batsignal -bi")
  start("/usr/lib/pam_kwallet_init")

  -- Desktop tray and session applications.
  start("sleep 1; nm-applet --indicator")
  start("sleep 1; blueman-tray")
  start(programs.browser, { workspace = "2 silent" })
end)
