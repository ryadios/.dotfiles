local terminal = require("lua.programs").terminal

-- Workspace defaults and scratchpads.
hl.workspace_rule({ workspace = "1", default = true })
hl.workspace_rule({
  workspace = "special:magic",
  on_created_empty = "vesktop",
  layout = "scrolling",
  gaps_in = 2,
})
hl.workspace_rule({
  workspace = "special:terminal",
  on_created_empty = terminal,
  layout = "scrolling",
  gaps_in = 2,
})

hl.window_rule({ match = { class = "^(vesktop|Vesktop)$" }, workspace = "special:magic silent" })

-- Float the Chromium Bitwarden extension popup without affecting Helium windows.
local bitwarden_class = "chrome-nngceckbapebfimnlniiiahkandclblb-Default"
local bitwarden_initial_title = "_crx_nngceckbapebfimnlniiiahkandclblb"

hl.window_rule({
  match = {
    class = "^" .. bitwarden_class .. "$",
    title = "^" .. bitwarden_initial_title .. "$",
  },
  float = true,
  center = true,
})

-- Float Helium popups immediately while keeping normal browser windows tiled.
hl.window_rule({
  match = {
    class = "^helium$",
    initial_title = "^Untitled - Helium$",
  },
  float = true,
  center = true,
  size = { "window_w", "monitor_h * 0.66" },
})

-- Center small utility windows.
hl.window_rule({ match = { class = "blueman-manager" }, float = true, center = true, size = { 618, 434 } })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, center = true, size = { 678, 500 } })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true, center = true })
hl.window_rule({ match = { class = "Choose Files" }, float = true, center = true })

-- Settings and desktop utility applications.
hl.window_rule({ match = { class = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "qt6ct" }, float = true, size = { 658, 763 } })
hl.window_rule({ match = { class = "kvantummanager" }, float = true, size = { 753, 730 } })
hl.window_rule({ match = { class = ".*desktop-portal-gtk.*" }, float = true })

-- Media and file-management windows.
hl.window_rule({ match = { class = "mpv" }, float = true, size = { "monitor_w * 0.7", "monitor_h * 0.7" } })
hl.window_rule({ match = { class = "obs" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, float = true })

-- Keep Kitty transparent while retaining the normal terminal opacity.
hl.window_rule({ match = { class = "kitty" }, opacity = "1 1 0.92" })

-- Keep browser picture-in-picture visible above other windows.
hl.window_rule({
  match = { title = "^Picture-in-Picture$" },
  float = true,
  pin = true,
  no_shadow = true,
  no_initial_focus = true,
  size = { "monitor_w * 0.25", "monitor_h * 0.25" },
  move = { "monitor_w - window_w - 20", "20" },
})
