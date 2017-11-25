-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}
-- gap size
local gaps = 5

-- not stable
-- expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
-- hs.hotkey.bind(mod,"E",'Expose',function()expose_space:toggleShow()end)

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

  f.x = max.x + (max.w * x) + gaps
  f.y = max.y + (max.h * y) + gaps
  f.w = max.w * w - (gaps * 2)
  f.h = max.h * h - (gaps * 2)
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

local verticalStart = 0;
local horizontalStart = 0;
local verticalEnd = 0.5;
local horizontalEnd = 0.5;


hs.hotkey.bind(mod, "G", function() getAllWindows() end)

-- window left 
hs.hotkey.bind(mod2, "H", function() push(0, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "H", function() focusWindows(hs.window.focusWindowWest()) end)

-- window left top
hs.hotkey.bind(mod2, "U", function() push(0, 0, 0.5, 0.5) end)

-- window fullscreen
hs.hotkey.bind(mod2, "I", function() push(0, 0, 1, 1) end)

-- window top
hs.hotkey.bind(mod2, "K", function() push(0, 0, 1, 0.5) end)
hs.hotkey.bind(mod, "K", function() focusWindows(hs.window.focusWindowNorth()) end)

-- window right top
hs.hotkey.bind(mod2, "O", function() push(0.5, 0, 0.5, 0.5) end)

-- window right
hs.hotkey.bind(mod2, "L", function() push(0.5, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "L", function() focusWindows(hs.window.focusWindowEast()) end)

-- window right bottom
hs.hotkey.bind(mod2, ".", function() push(0.5, 0.5, 0.5, 0.5) end)

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
hs.hotkey.bind(mod, "C", function()
    hs.application.open("Visual Studio Code")
end)

hs.hotkey.bind(mod, "f", function()
  hs.application.open("Finder")
end)
