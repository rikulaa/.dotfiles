-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}

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




-- hs.hotkey.bind({"mod", "alt", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   win:setFrame(f)

hs.hotkey.bind(mod, "A", function() getAllWindows() end)

-- window left 
hs.hotkey.bind(mod2, "H", function() push(0, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "H", function() hs.window.focusWindowWest() end)
-- hs.hotkey.bind(mod, "H", function() push(0, 0, 0.5, 1) end)

-- window left top
hs.hotkey.bind(mod2, "U", function() push(0, 0, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, "U", function() hs.grid.pushWindowUp() end)

-- window fullscreen
hs.hotkey.bind(mod2, "I", function() push(0, 0, 1, 10) end)
-- hs.hotkey.bind(mod, "I", function()  end)

-- window top
hs.hotkey.bind(mod2, "K", function() push(0, 0, 1, 0.5) end)
hs.hotkey.bind(mod, "K", function() hs.window.focusWindowNorth() end)
-- hs.hotkey.bind(mod, "K", function() push(0, 0, 1, 10) end)

-- window right top
hs.hotkey.bind(mod2, "O", function() push(0.5, 0, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, "O", function() push(0, 0, 1, 10) end)

-- window right
hs.hotkey.bind(mod2, "L", function() push(0.5, 0, 0.5, 1) end)
hs.hotkey.bind(mod, "L", function() hs.window.focusWindowEast() end)
-- hs.hotkey.bind(mod, "L", function() push(0, 0, 1, 10) end)

-- window right bottom
hs.hotkey.bind(mod2, ".", function() push(0.5, 0.5, 0.5, 0.5) end)
-- hs.hotkey.bind(mod, ".", function() push(0, 0, 1, 10) end)

-- window bottom
hs.hotkey.bind(mod2, "J", function() push(0, 0.5, 1, 0.5) end)
hs.hotkey.bind(mod, "J", function() hs.window.focusWindowSouth() end)


-- window left bottom
hs.hotkey.bind(mod2, "N", function() push(0, 0.5, 0.5, 0.5) end)

-- open terminal
hs.hotkey.bind(mod, "return", function()
    hs.application.open("iTerm");
end)

-- open browser
hs.hotkey.bind(mod, "b", function()
    hs.application.open("firefox");
end)

-- open editor
hs.hotkey.bind(mod, "e", function()
    hs.application.open("Visual Studio Code");
end)

