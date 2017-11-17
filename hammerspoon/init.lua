-- local cmd = {"cmd", "alt", "ctrl"};
local cmd = {"alt"};

hs.hotkey.bind(cmd, "R", function()
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

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   win:setFrame(f)

-- window left 
hs.hotkey.bind(cmd, "H", function() push(0, 0, 0.5, 1) end)

-- window left top
hs.hotkey.bind(cmd, "U", function() push(0, 0, 0.5, 0.5) end)

-- window fullscreen
hs.hotkey.bind(cmd, "I", function() push(0, 0, 1, 10) end)

-- window top
hs.hotkey.bind(cmd, "K", function() push(0, 0, 1, 0.5) end)

-- window right top
hs.hotkey.bind(cmd, "O", function() push(0.5, 0, 0.5, 0.5) end)

-- window right
hs.hotkey.bind(cmd, "L", function() push(0.5, 0, 0.5, 1) end)

-- window right bottom
hs.hotkey.bind(cmd, ".", function() push(0.5, 0.5, 0.5, 0.5) end)

-- window bottom
hs.hotkey.bind(cmd, "J", function()
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

--window left bottom
hs.hotkey.bind(cmd, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x 
  f.y = max.y + (max.h / 2) 
  f.w = max.w / 2
  f.h = max.h  
  win:setFrame(f)
end)


-- open terminal
hs.hotkey.bind(cmd, "t", function()
    -- local iterm = hs.application:name('iterm2');
    hs.application.open("iTerm");
end)

-- open browser
hs.hotkey.bind(cmd, "b", function()
    -- local iterm = hs.application:name('iterm2');
    hs.application.open("firefox");
end)

-- open editor
hs.hotkey.bind(cmd, "e", function()
    -- local iterm = hs.application:name('iterm2');
    hs.application.open("Visual Studio Code");
end)

