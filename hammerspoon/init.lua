-- Reload Hammerspoon
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Layouts

positions = {
  maximized = {x=0.05, y=0.05, w=0.9, h=0.9},
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},

  left50 = {x=0.01, y=0.01, w=0.48, h=0.98},
  right50 = {x=0.51, y=0.01, w=0.48, h=0.98},

  upper50 = {x=0.01, y=0.01, w=.98, h=0.48},
  upper50Left50 = {x=0.01, y=0.01, w=0.48, h=0.48},
  upper50Right50 = {x=0.51, y=0.01, w=0.48, h=0.48},

  lower50Left50 = {x=0.01, y=0.51, w=0.48, h=0.48},
  lower50Right50 = {x=0.51, y=0.51, w=0.48, h=0.48},

  lower50 = {x=0.01, y=0.51, w=.98, h=0.48},
}

grid = {
  {key="u", units={positions.upper50Left50}},
  {key="i", units={positions.upper50Right50}},
  {key="o", units={positions.lower50Left50}},
  {key="p", units={positions.lower50Right50}},

  {key="h", units={positions.left50}},
  {key="j", units={positions.lower50}},
  {key="k", units={positions.upper50}},
  {key="l", units={positions.right50}},

  {key="m", units={positions.maximized}},
  {key="n", units={positions.centered}},
}

function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "alt"}, key, fn)
end

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
      return windowGeo:equals(geo)
    end)
    if index == #units then index = 0 end

    window:moveToUnit(units[index + 1])
  end)
end)

function moveWindowToDisplay(d)
    return function()
        local displays = hs.screen.allScreens()
        local win = hs.window.focusedWindow()
        win:moveToScreen(displays[d], false, true)
    end
end

hs.hotkey.bind({"ctrl", "shift"}, "1", moveWindowToDisplay(1))
hs.hotkey.bind({"ctrl", "shift"}, "2", moveWindowToDisplay(2))
hs.hotkey.bind({"ctrl", "shift"}, "3", moveWindowToDisplay(3))

hs.hotkey.bind({"ctrl", "cmd", "alt"}, "3", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  hs.layout.apply({
    {"Mail", nil, screen, positions.left50,         nil, nil},
    {"Keybase",    nil, screen, positions.upper50Right50, nil, nil},
    {"Slack",   nil, screen, positions.lower50Right50, nil, nil}
  })
      --{"iTunes",  "iTunes",     laptopScreen, hs.layout.maximized, nil, nil},
      --{"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
end)

hs.alert.show("Hammerspoon config loaded successfully")
