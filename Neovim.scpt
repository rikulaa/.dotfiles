tell application "iTerm"
	activate
	set newWindow to (create window with default profile)
	
	
	tell current session of newWindow
		write text "nvim --cmd startinsert; exit"
	end tell
	
	activate
end tell
