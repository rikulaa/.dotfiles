-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}

-- hightlight current window (blur other)
-- hs.window.highlight.ui.overlay=true
-- hs.window.highlight.start()


-- switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- hs.hotkey.bind('alt','tab','Next window',function()switcher:next()end)

function setGrid() 
  hs.grid.setGrid('2x2', hs.screen.primaryScreen())
end
setGrid()


hs.hotkey.bind(mod, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")


function push(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * x)
  f.y = max.y + (max.h * y)
  f.w = max.w * w
  f.h = max.h * h
  win:setFrame(f)
end

function getAllWindows() 
  local windows = hs.window.orderedWindows()
  -- io.write('hello')
  hs.grid.show()
end

function focusWindows(focusDirection)
  if not focusDirection then
    local win = hs.window.focusedWindow()
    win:sendToBack()
    -- local otherWindows = hs.window:otherWindowsAllScreens()
    -- if otherWindows[1] then hs.window.focus(otherWindows[1]) end
  end
end


hs.hotkey.bind(mod, "A", function() getAllWindows() end)

-- window left 
hs.hotkey.bind(mod2, "H", function() push(0, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "H", function() focusWindows(hs.window.focusWindowWest()) end)

-- window left top
hs.hotkey.bind(mod2, "U", function() push(0, 0, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, "U", function() hs.grid.pushWindowUp() end)

-- window fullscreen
hs.hotkey.bind(mod2, "I", function() push(0, 0, 1, 10) end)
-- hs.hotkey.bind(mod, "I", function()  end)

-- window top
hs.hotkey.bind(mod2, "K", function() push(0, 0, 1, 0.5) end)
hs.hotkey.bind(mod, "K", function() focusWindows(hs.window.focusWindowNorth()) end)
-- hs.hotkey.bind(mod, "K", function() push(0, 0, 1, 10) end)

-- window right top
hs.hotkey.bind(mod2, "O", function() push(0.5, 0, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, "O", function() push(0, 0, 1, 10) end)

-- window right
hs.hotkey.bind(mod2, "L", function() push(0.5, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "L", function() focusWindows(hs.window.focusWindowEast()) end)
-- hs.hotkey.bind(mod, "L", function() push(0, 0, 1, 10) ejd)

-- window right bottom
hs.hotkey.bind(mod2, ".", function() push(0.5, 0.5, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, ".", function() push(0, 0, 1, 10) end)

-- window bottom
hs.hotkey.bind(mod2, "J", function() push(0, 0.5, 1, 0.5) end)
hs.hotkey.bind(mod, "J", function() focusWindows(hs.window.focusWindowSouth()) end)


-- window left bottom
hs.hotkey.bind(mod2, "N", function() push(0, 0.5, 0.5, 0.5) end)

-- move windows between screen
hs.hotkey.bind(mod2, "M", function() 
  -- hack which only support two monitors properly
  local win = hs.window.focusedWindow()
  if win:moveOneScreenWest(0) then
    return
  end
   if win:moveOneScreenEast(0) then
    return
   end
end)

-- open terminal
hs.hotkey.bind(mod, "return", function()
    hs.application.open("iTerm")
end)

-- open browser
hs.hotkey.bind(mod, "b", function()
    hs.application.open("Google Chrome")
end)

-- open editor
hs.hotkey.bind(mod, "e", function()
    hs.application.open("Visual Studio Code")
end)

hs.hotkey.bind(mod, "f", function()
  hs.application.open("Finder")
end)