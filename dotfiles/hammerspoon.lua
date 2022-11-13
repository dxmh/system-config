require "scratchpad"

hs.window.animationDuration = 0
hs.grid.setMargins({25,25})
hs.grid.setGrid('10x10')

local hyper = {"control", "option", "command"}
local shift_hyper = {"shift", "control", "option", "command"}

local function contains(table, element)
	for _, value in ipairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local screenPositions = {
  left = {x=0, y=0, w=6, h=10},
  left_top = {x=0, y=0, w=6, h=5},
  left_bottom = {x=0, y=5, w=6, h=5},
  right = {x=6, y=0, w=4, h=10},
  right_top = {x=6, y=0, w=4, h=5},
  right_bottom = {x=6, y=5, w=4, h=5},
  big = {x=0, y=0, w=10, h=10},
  middle = {x=2, y=1, w=6, h=8}
}

local appKeys = {
  -- osascript -e 'id of app "Foo"'
  [","] = "com.apple.systempreferences",
  ["c"] = "com.google.Chrome",
  ["d"] = "com.apple.iCal",
  ["e"] = "com.apple.mail",
  ["f"] = "com.apple.finder",
  ["i"] = "pro.writer.mac",
  ["k"] = "net.kovidgoyal.kitty",
  ["l"] = "com.tinyspeck.slackmacgap",
  ["m"] = "com.apple.MobileSMS",
  ["n"] = "com.apple.Notes",
  ["p"] = "com.apple.Preview",
  ["r"] = "com.apple.reminders",
  ["s"] = "com.apple.Safari",
  ["t"] = "net.kovidgoyal.kitty", -- t for terminal, for muscle memory
  ["u"] = "com.apple.Music",
  ["x"] = "Passwords",
  ["z"] = "us.zoom.xos",
}

local function toggleApp(myApp)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.application.find(myApp)
  if app ~= nil and app:isFrontmost() then
    app:hide()
  else
    hs.application.open(myApp)
  end
end

local function hideAppsExcept(myApps)
	for _, app in ipairs(myApps) do
  	hs.application.open(app)
  end
	for _, window in pairs(hs.window.visibleWindows()) do
		thisApp = window:application():bundleID()
		if not contains(myApps, thisApp) then
			window:application():hide()
		end
	end
end

for k, v in pairs(appKeys) do
  hs.hotkey.bind(hyper, k, function()
    hideAppsExcept({v})
    hs.grid.set(hs.application.get(v):mainWindow(), screenPositions.big)
  end)
end

hs.hotkey.bind(hyper, "up", function() hs.window.filter.focusNorth() end)
hs.hotkey.bind(hyper, "right", function() hs.window.filter.focusEast() end)
hs.hotkey.bind(hyper, "down", function() hs.window.filter.focusSouth() end)
hs.hotkey.bind(hyper, "left", function() hs.window.filter.focusWest() end)

hs.hotkey.bind(shift_hyper, "up", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.big) end)
hs.hotkey.bind(shift_hyper, "right", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.right) end)
hs.hotkey.bind(shift_hyper, "down", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.middle) end)
hs.hotkey.bind(shift_hyper, "left", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.left) end)

hs.hotkey.bind(hyper, "1", function()
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.right)
end)

hs.hotkey.bind(hyper, "2", function()
  hs.grid.set(hs.application.open("us.zoom.xos"):mainWindow(), screenPositions.left_top)
  hs.grid.set(hs.application.open("pro.writer.mac"):mainWindow(), screenPositions.left_bottom)
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.right)
end)

hs.hotkey.bind(hyper, "3", function()
  hs.grid.set(hs.application.open("com.apple.iCal"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("com.apple.reminders"):mainWindow(), screenPositions.right)
end)

hs.hotkey.bind(hyper, "h", function()
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("org.hammerspoon.Hammerspoon"):mainWindow(), screenPositions.right)
end)
