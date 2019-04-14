-- local mod = {"cmd", "alt", "ctrl"};
local mod = {"alt"};
local mod2 = {"alt", "shift"}

function initWindowManager()
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
end


-- SHORTCUTS
function initShortcuts()
  -- open terminal
  hs.hotkey.bind(mod, "return", function()
      local iterm = hs.application.get('iTerm')
      hs.application.open('iTerm')
      -- hs.application.open('Kitty')
      -- hs.application.get('Kitty')
      local menu = hs.application.getMenuItems()
      hs.alert.show(menu)
  end)

  -- open browser
  -- hs.hotkey.bind(mod, "b", function()
  --     hs.application.open("Firefox")
  -- end)

  -- open editor
  hs.hotkey.bind(mod, "C", function()
      hs.application.open("Visual Studio Code")
  end)

  -- hs.hotkey.bind(mod, "f", function()
  --   hs.application.open("Finder")
  -- end)

  hs.hotkey.bind(mod, "R", function()
    hs.reload()
  end)
end


-- VIM MODE
function initVimMode()
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
end


initWindowManager()
initShortcuts()
initVimMode()


hs.alert.show("Config loaded")


--[[
-- FROM https://github.com/VFS/.hammerspoon/blob/master/tools/clipboard.lua
This is my attempt to implement a jumpcut replacement in Lua/Hammerspoon.
It monitors the clipboard/pasteboard for changes, and stores the strings you copy to the transfer area.
You can access this history on the menu (Unicode scissors icon).
Clicking on any item will add it to your transfer area.
If you open the menu while pressing option/alt, you will enter the Direct Paste Mode. This means that the selected item will be
"typed" instead of copied to the active clipboard.
The clipboard persists across launches.
-> Ng irc suggestion: hs.settings.set("jumpCutReplacementHistory", clipboard_history)
]]--

-- Feel free to change those settings
local frequency = 0.8 -- Speed in seconds to check for clipboard changes. If you check too frequently, you will loose performance, if you check sparsely you will loose copies
local hist_size = 20 -- How many items to keep on history
local label_length = 40 -- How wide (in characters) the dropdown menu should be. Copies larger than this will have their label truncated and end with "…" (unicode for elipsis ...)
local honor_clearcontent = false --asmagill request. If any application clears the pasteboard, we also remove it from the history https://groups.google.com/d/msg/hammerspoon/skEeypZHOmM/Tg8QnEj_N68J
local pasteOnSelect = false -- Auto-type on click

-- Don't change anything bellow this line
local jumpcut = hs.menubar.new()
jumpcut:setTooltip("Jumpcut replacement")
local pasteboard = require("hs.pasteboard") -- http://www.hammerspoon.org/docs/hs.pasteboard.html
local settings = require("hs.settings") -- http://www.hammerspoon.org/docs/hs.settings.html
local last_change = pasteboard.changeCount() -- displays how many times the pasteboard owner has changed // Indicates a new copy has been made

--Array to store the clipboard history
local clipboard_history = settings.get("so.victor.hs.jumpcut") or {} --If no history is saved on the system, create an empty history

-- Append a history counter to the menu
function setTitle()
	if (#clipboard_history == 0) then
		jumpcut:setTitle("✂") -- Unicode magic
	else
		jumpcut:setTitle("✂ ("..#clipboard_history..")") -- updates the menu counter
	end
end

function putOnPaste(string,key)
	if (pasteOnSelect) then
		hs.eventtap.keyStrokes(string)
		pasteboard.setContents(string)
		last_change = pasteboard.changeCount()
	else
		if (key.alt == true) then -- If the option/alt key is active when clicking on the menu, perform a "direct paste", without changing the clipboard
			hs.eventtap.keyStrokes(string) -- Defeating paste blocking http://www.hammerspoon.org/go/#pasteblock
		else
			pasteboard.setContents(string)
			last_change = pasteboard.changeCount() -- Updates last_change to prevent item duplication when putting on paste
		end
	end
end

-- Clears the clipboard and history
function clearAll()
	pasteboard.clearContents()
	clipboard_history = {}
	settings.set("so.victor.hs.jumpcut",clipboard_history)
	now = pasteboard.changeCount()
	setTitle()
end

-- Clears the last added to the history
function clearLastItem()
	table.remove(clipboard_history,#clipboard_history)
	settings.set("so.victor.hs.jumpcut",clipboard_history)
	now = pasteboard.changeCount()
	setTitle()
end

function pasteboardToClipboard(item)
	-- Loop to enforce limit on qty of elements in history. Removes the oldest items
	while (#clipboard_history >= hist_size) do
		table.remove(clipboard_history,1)
	end
	table.insert(clipboard_history, item)
	settings.set("so.victor.hs.jumpcut",clipboard_history) -- updates the saved history
	setTitle() -- updates the menu counter
end

-- Dynamic menu by cmsj https://github.com/Hammerspoon/hammerspoon/issues/61#issuecomment-64826257
populateMenu = function(key)
	setTitle() -- Update the counter every time the menu is refreshed
	menuData = {}
	if (#clipboard_history == 0) then
		table.insert(menuData, {title="None", disabled = true}) -- If the history is empty, display "None"
	else
		for k,v in pairs(clipboard_history) do
			if (string.len(v) > label_length) then
				table.insert(menuData,1, {title=string.sub(v,0,label_length).."…", fn = function() putOnPaste(v,key) end }) -- Truncate long strings
			else
				table.insert(menuData,1, {title=v, fn = function() putOnPaste(v,key) end })
			end -- end if else
		end-- end for
	end-- end if else
	-- footer
	table.insert(menuData, {title="-"})
	table.insert(menuData, {title="Clear All", fn = function() clearAll() end })
	if (key.alt == true or pasteOnSelect) then
		table.insert(menuData, {title="Direct Paste Mode ✍", disabled=true})
	end
	return menuData
end

-- If the pasteboard owner has changed, we add the current item to our history and update the counter.
function storeCopy()
	now = pasteboard.changeCount()
	if (now > last_change) then
		current_clipboard = pasteboard.getContents()
		-- asmagill requested this feature. It prevents the history from keeping items removed by password managers
		if (current_clipboard == nil and honor_clearcontent) then
			clearLastItem()
		else
			pasteboardToClipboard(current_clipboard)
		end
		last_change = now
	end
end

--Checks for changes on the pasteboard. Is it possible to replace with eventtap?
timer = hs.timer.new(frequency, storeCopy)
timer:start()

setTitle() --Avoid wrong title if the user already has something on his saved history
jumpcut:setMenu(populateMenu)
