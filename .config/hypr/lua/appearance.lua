hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = 1.7,
})
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

hl.config({
  binds = {
    focus_preferred_method = 1,
  },
  dwindle = {
    preserve_split = true,
    force_split = 2,
    special_scale_factor = 0.95,
  },
  scrolling = {
    column_width = 0.9,
  },
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,
  },
  cursor = {
    no_hardware_cursors = 2,
    no_break_fs_vrr = 2,
    inactive_timeout = 3,
    hide_on_key_press = true,
  },
  xwayland = {
    force_zero_scaling = true,
  },
  decoration = {
    rounding = 8,
    blur = {
      enabled = true,
      size = 4,
      passes = 3,
    },
    shadow = {
      enabled = true,
      range = 32,
      render_power = 3,
      color = "rgba(00000055)",
      offset = { 0, 8 },
    },
    dim_inactive = true,
    dim_strength = 0.1,
    dim_special = 0.4,
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    focus_on_activate = true,
    on_focus_under_fullscreen = 1,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
    animate_mouse_windowdragging = true,
    animate_manual_resizes = true,
    -- Hide Kitty/Tmux while their child GUI app is open.
    enable_swallow = true,
    swallow_regex = "kitty|tmux",
    disable_autoreload = true,
  },
  animations = {
    enabled = true,
  },
})

-- Keep the custom motion profile while leaving Hyprland defaults untouched elsewhere.
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("macEase", { type = "bezier", points = { { 0.25, 1.0 }, { 0.5, 1.0 } } })
hl.curve("macPop", { type = "bezier", points = { { 0.2, 0.8 }, { 0.4, 1.1 } } })
hl.curve("macSmooth", { type = "bezier", points = { { 0.4, 0.0 }, { 0.2, 1.0 } } })
hl.curve("macBounce", { type = "bezier", points = { { 0.68, -0.55 }, { 0.265, 1.55 } } })

hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "macEase", style = "popin 90%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "macPop" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "macSmooth", style = "fade" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 3, bezier = "macSmooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "macEase", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "macBounce", style = "slidefadevert 15%" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "macEase" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "macEase" })
