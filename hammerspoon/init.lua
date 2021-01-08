-- Reload Hammerspoon
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Layouts

positions = {
  maximized = {x=0.05, y=0.05, w=0.9, h=0.9},
  centered = {x=0.1, y=0.1, w=0.8, h=0.8},

  left50 = {x=0.01, y=0.01, w=0.48, h=0.98},
  right50 = {x=0.51, y=0.01, w=0.48, h=0.98},
  upper50 = {x=0.01, y=0.01, w=.98, h=0.48},
  lower50 = {x=0.01, y=0.51, w=.98, h=0.48},
}

grid = {
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

hs.alert.show("Hammerspoon config loaded successfully")
