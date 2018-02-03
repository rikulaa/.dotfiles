-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}
-- gap size
local gaps = 5

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

function pushHorizontal(x, w)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * x) + gaps
  f.w = max.w * w - (gaps * 2)
  win:setFrame(f)
end

function pushVertical(y, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y + (max.h * y) + gaps
  f.h = max.h * h - (gaps * 2)
  win:setFrame(f)
end


function getAllWindows() 
  local windows = hs.window.orderedWindows()
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

-- local _stepMultiplier = 0
local _stepMultiplierHorizontal = 0
local _stepMultiplierVertical = 0

local _verticalStart = 0
local _horizontalStart = 0
local _step = 0.25
local _direction = ""
local _maxSteps = 0.5 / _step


function checkDirectionHorizontal(direction) 
  if direction == _direction then
    if _stepMultiplierHorizontal < _maxSteps then
      _stepMultiplierHorizontal = _stepMultiplierHorizontal + 1
    else _stepMultiplierHorizontal = -1
    end
  else

    _stepMultiplierHorizontal = 0
  end

  _direction = direction
end

function checkDirectionVertical(direction) 
  if direction == _direction then
    if _stepMultiplierVertical < _maxSteps then
      _stepMultiplierVertical = _stepMultiplierVertical + 1
    else _stepMultiplierVertical = -1
    end
  else

    _stepMultiplierVertical = 0
  end

  _direction = direction
end

hs.hotkey.bind(mod, "G", function() getAllWindows() end)

-- window left 
hs.hotkey.bind(mod2, "H", function()
  checkDirectionHorizontal("left")
  pushHorizontal(0, 0.5 + (_step * _stepMultiplierHorizontal))
  end)
hs.hotkey.bind(mod, "H", function() focusWindows(hs.window.focusWindowWest()) end)

-- window left top
hs.hotkey.bind(mod2, "U", function() push(0, 0, 0.5, 0.5) end)

-- window fullscreen
hs.hotkey.bind(mod2, "I", function() 
  _direction = ""
  push(0, 0, 1, 1) 
end)

-- window top
hs.hotkey.bind(mod2, "K", function()
  checkDirectionVertical("up")
  pushVertical(0, 0.5 + (_step * _stepMultiplierVertical))
end)
hs.hotkey.bind(mod, "K", function() focusWindows(hs.window.focusWindowNorth()) end)

-- window right top
hs.hotkey.bind(mod2, "O", function() push(0.5, 0, 0.5, 0.5) end)

-- window right
hs.hotkey.bind(mod2, "L", function()
  checkDirectionHorizontal("right")
  pushHorizontal(0.5 - (_step * _stepMultiplierHorizontal), 0.5 + (_step * _stepMultiplierHorizontal))
end)
hs.hotkey.bind(mod, "L", function() focusWindows(hs.window.focusWindowEast()) end)

-- window right bottom
hs.hotkey.bind(mod2, ".", function() push(0.5, 0.5, 0.5, 0.5) end)

-- window bottom
hs.hotkey.bind(mod2, "J", function() 
  checkDirectionVertical("down")
  pushVertical(0.5 - (_step * _stepMultiplierVertical), 0.5 + (_step * _stepMultiplierVertical))
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
    -- local iterm = hs.application.get('iTerm')
    hs.application.open('iTerm')
    hs.application.get('iTerm')
    local menu = hs.application.getMenuItems()
    hs.alert.show(menu)
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


-- App watcher
-- event == 5 (application focused)
-- event == 6 (application defocused)
local appWatcher = hs.application.watcher.new(function(name, event, app) 
  if name == "Finder" then
    if event == 5 then
      vimModeStart()
    end

    if event == 6 then
      vimModeEnd()
    end
  end

end)
appWatcher:start()

-- VIM mode
local vimKeyModifier = hs.eventtap.new({10}, function(event) 
  local keyCode = event:getKeyCode()
  local flags = event:getFlags() 
  local isCtrlPressed = flags.ctrl

  -- left
  if keyCode == 4 and isCtrlPressed then
    return true, {hs.eventtap.event.newKeyEvent(123, true)}
  end

  -- down 
  if keyCode == 38 and isCtrlPressed then
    return true, {hs.eventtap.event.newKeyEvent(125, true)}
  end

  -- up 
  if keyCode == 40 and isCtrlPressed then
    return true, {hs.eventtap.event.newKeyEvent(126, true)}
  end

  -- right 
  if keyCode == 37 and isCtrlPressed then
    return true, {hs.eventtap.event.newKeyEvent(124, true)}
  end

  return false
end)

function vimModeStart() 
  vimKeyModifier:start()  
end

function vimModeEnd() 
  vimKeyModifier:stop()
end

-- Spoons
hs.loadSpoon("Calendar")