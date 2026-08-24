hl.config({
  input = {
    repeat_rate = 50,
    repeat_delay = 300,
    mouse_refocus = false,
    sensitivity = 0.6,
    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      clickfinger_behavior = true,
    },
  },
  gestures = {
    workspace_swipe_distance = 500,
    workspace_swipe_cancel_ratio = 0.35,
    workspace_swipe_min_speed_to_force = 5,
    workspace_swipe_direction_lock_threshold = 6,
  },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({
  fingers = 3,
  direction = "up",
  action = "special",
  workspace_name = "terminal",
})
hl.gesture({
  fingers = 3,
  direction = "down",
  action = "special",
  workspace_name = "terminal",
})
