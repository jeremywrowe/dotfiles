-- Reload Hammerspoon
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)

-- Make the window the size of the top of the screen
hs.hotkey.bind({"ctrl", "shift"}, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Make the window the size of the bottom of the screen
hs.hotkey.bind({"ctrl", "shift"}, "J", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Make the window the size of the left side of the screen
hs.hotkey.bind({"ctrl", "shift"}, "K", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)
  
-- Make the current window the size of the right side of the screen
hs.hotkey.bind({"ctrl", "shift"}, "L", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Make the current window full screen
hs.hotkey.bind({"ctrl", "shift"}, "F", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f, 0)
end)

-- Make the current window almost full screen, meant for screen sharing
hs.hotkey.bind({"ctrl", "shift"}, "B", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w * 0.025)
    f.y = max.y + (max.h * 0.025)
    f.w = max.w * 0.95
    f.h = max.h * 0.95
    win:setFrame(f, 0)
end)

-- Make the current window almost full screen, but centered
hs.hotkey.bind({"ctrl", "shift"}, "M", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w * 0.05)
    f.y = max.y + (max.h * 0.05)
    f.w = max.w * 0.90
    f.h = max.h * 0.90
    win:setFrame(f, 0)
end)

-- Make the current window almost full screen, but centered and slightly smaller
hs.hotkey.bind({"ctrl", "shift"}, "N", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w * 0.15)
    f.y = max.y + (max.h * 0.15)
    f.w = max.w * 0.70
    f.h = max.h * 0.70
    win:setFrame(f, 0)
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
