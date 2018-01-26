-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}
-- gap size
local gaps = 5

-- not stable
-- expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
-- hs.hotkey.bind(mod,"E","Expose",function()expose_space:toggleShow()end)

-- hightlight current window (blur other)
-- hs.window.highlight.ui.overlay=true
-- hs.window.highlight.start()


-- switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- hs.hotkey.bind("alt","tab","Next window",function()switcher:next()end)


-- local onScreenChange = function () 
--   hs.alert.show("external")
-- end

local screenWatcher = hs.screen.watcher.new(function()
end)

screenWatcher:start()

function setGrid() 
  -- hs.grid.setGrid("8x4", hs.screen.primaryScreen())
  hs.grid.setGrid("6x6", hs.screen.primaryScreen())
  local external = hs.screen.primaryScreen():next()
  hs.alert.show(external)
  if external then
    -- hs.grid.setGrid("6x6", external)
    hs.grid.setGrid("6x6", external)
  end
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
  -- io.write("hello")
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

local _stepMultiplier = 0
local _verticalStart = 0
local _horizontalStart = 0
local _verticalEnd = 0.5
local _horizontalEnd = 0.5
local _step = 0.25
local _direction = ""
local _maxSteps = 0.5 / _step


function checkDirection(direction) 
  if direction == _direction then
    if _stepMultiplier < _maxSteps then
      _stepMultiplier = _stepMultiplier + 1
    else _stepMultiplier = -1
    end
  else

    _stepMultiplier = 0
  end

  _direction = direction
end

hs.hotkey.bind(mod, "G", function() getAllWindows() end)

-- window left 
hs.hotkey.bind(mod2, "H", function()
  checkDirection("left")
  push(0, 0, 0.5 + (_step * _stepMultiplier), 1) 
  end)
hs.hotkey.bind(mod, "H", function() focusWindows(hs.window.focusWindowWest()) end)

-- window left top
hs.hotkey.bind(mod2, "U", function() push(0, 0, 0.5, 0.5) end)

-- window fullscreen
hs.hotkey.bind(mod2, "I", function() push(0, 0, 1, 1) end)

-- window top
hs.hotkey.bind(mod2, "K", function()
  checkDirection("up")
  push(0, 0, 1, 0.5 + (_step * _stepMultiplier)) 
end)
hs.hotkey.bind(mod, "K", function() focusWindows(hs.window.focusWindowNorth()) end)

-- window right top
hs.hotkey.bind(mod2, "O", function() push(0.5, 0, 0.5, 0.5) end)

-- window right
hs.hotkey.bind(mod2, "L", function()
  checkDirection("right")
  push(0.5 - (_step * _stepMultiplier), 0, 0.5 + (_step * _stepMultiplier), 1) 
end)
hs.hotkey.bind(mod, "L", function() focusWindows(hs.window.focusWindowEast()) end)

-- window right bottom
hs.hotkey.bind(mod2, ".", function() push(0.5, 0.5, 0.5, 0.5) end)

-- window bottom
hs.hotkey.bind(mod2, "J", function() 
  checkDirection("down")
  push(0, 0.5 - (_step * _stepMultiplier), 1, 0.5 + (_step * _stepMultiplier)) 
end)
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
