local home = os.getenv("HOME") or ""
local programs = require("lua.programs")

local function command(path, args)
  return hl.dsp.exec_cmd(path .. (args and (" " .. args) or ""))
end

-- Workspace navigation.
for i = 1, 10 do
  local key = i == 10 and "0" or tostring(i)
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

local function focus(direction)
  local window = hl.get_active_window()
  if window and window.floating then
    local previous = direction == "l" or direction == "u"
    hl.dispatch(hl.dsp.window.cycle_next({ next = not previous, floating = true }))
    local focused = hl.get_active_window()
    if focused and focused.floating then
      hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
    end
    return
  end

  hl.dispatch(hl.dsp.focus({ direction = direction }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end

local function move(direction)
  local window = hl.get_active_window()
  if window and window.floating then
    hl.dispatch(hl.dsp.window.move({
      x = direction == "l" and -50 or direction == "r" and 50 or 0,
      y = direction == "u" and -50 or direction == "d" and 50 or 0,
      relative = true,
    }))
    return
  end

  hl.dispatch(hl.dsp.window.move({ direction = direction }))
end

for key, direction in pairs({ h = "l", j = "d", k = "u", l = "r" }) do
  hl.bind("SUPER + " .. key, function()
    focus(direction)
  end)
  hl.bind("SUPER + CTRL + " .. key, hl.dsp.window.resize({
    x = direction == "l" and -50 or direction == "r" and 50 or 0,
    y = direction == "u" and -50 or direction == "d" and 50 or 0,
    relative = true,
  }), { repeating = true })
  hl.bind("SUPER + SHIFT + " .. key, function()
    move(direction)
  end, { repeating = true })
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Hardware controls.
hl.bind("XF86AudioRaiseVolume", command(home .. "/.local/bin/volume", "up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", command(home .. "/.local/bin/volume", "down"), { repeating = true })
hl.bind("XF86AudioMute", command(home .. "/.local/bin/volume", "mute"))
hl.bind("XF86Launch6", command(home .. "/.local/bin/mic"))
hl.bind("XF86AudioPlay", command("playerctl", "play-pause"), { locked = true })
hl.bind("XF86AudioPause", command("playerctl", "play-pause"), { locked = true })
hl.bind("XF86AudioNext", command("playerctl", "next"), { locked = true })
hl.bind("XF86AudioPrev", command("playerctl", "previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", command(home .. "/.local/bin/brightness", "up"), { repeating = true })
hl.bind("XF86MonBrightnessDown", command(home .. "/.local/bin/brightness", "down"), { repeating = true })

-- Core window actions.
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + E", command(programs.file_manager))
hl.bind("SUPER + B", command(programs.browser))
hl.bind("SUPER + SHIFT + E", command("wlogout"))
hl.bind("SUPER + RETURN", command(programs.terminal))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.pseudo())
hl.bind("SUPER + SHIFT + X", hl.dsp.window.kill())
hl.bind("SUPER + SHIFT + A", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("SUPER + SHIFT + C", hl.dsp.window.center())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

local function minimize()
  if hl.get_workspace("special:minimized") then
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
    hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
  else
    hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
  end
end

hl.bind("SUPER + D", minimize)

local MAX_ZOOM = 3
local function zoom(offset)
  local current = hl.get_config("cursor.zoom_factor")
  current = offset == nil and 1 or current + offset
  current = math.max(1, math.min(MAX_ZOOM, current))
  hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + equal", function()
  zoom(0.1)
end, { repeating = true })
hl.bind("SUPER + minus", function()
  zoom(-0.1)
end, { repeating = true })
hl.bind("SUPER + SHIFT + equal", zoom)
hl.bind("SUPER + SHIFT + minus", zoom)

-- Session and launcher actions.
hl.bind("SUPER + R", command("hyprctl", "reload"))
hl.bind("SUPER + SHIFT + R", command("killall", "-SIGUSR2 waybar"))
hl.bind("SUPER + V", command("vicinae", "vicinae://launch/clipboard/history"))
hl.bind("SUPER + SPACE", command("vicinae", "vicinae://toggle"))
hl.bind("SUPER + period", command("vicinae", "vicinae://launch/core/search-emojis"))
hl.bind("ALT + S", command("screenshot", "area"))
hl.bind("ALT + SHIFT + S", command("screenshot", "full"))

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("terminal"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminal" }))
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

for key, direction in pairs({ left = "l", down = "d", up = "u", right = "r" }) do
  hl.bind("SUPER + CTRL + " .. key, hl.dsp.window.resize({
    x = direction == "l" and -50 or direction == "r" and 50 or 0,
    y = direction == "u" and -50 or direction == "d" and 50 or 0,
    relative = true,
  }), { repeating = true })
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

hl.bind("CTRL + SHIFT + M", hl.dsp.pass({ window = "class:^(vesktop|discord)$" }))

local touchpad = "syna7dab:01-06cb:cd40-touchpad"
hl.bind("XF86TouchpadOn", command("hyprctl", 'keyword "device[' .. touchpad .. ']:enabled" true && notify-send "Touchpad: On"'))
hl.bind("XF86TouchpadOff", command("hyprctl", 'keyword "device[' .. touchpad .. ']:enabled" false && notify-send "Touchpad: Off"'))
