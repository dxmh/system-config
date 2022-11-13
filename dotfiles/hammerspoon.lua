require "scratchpad"

-- Set up our leader key (I've remapped Capslock to F19 elsewhere)
local m = hs.hotkey.modal.new('', 'f19')

function m:entered()
  mIndicator = hs.alert'Leader...'
  hs.timer.doAfter(2, function() m:exit() end)
end

function m:exited()
  hs.alert.closeSpecific(mIndicator)
end

m:bind('', 'escape', function() m:exit() end)
m:bind('', 'f19', function() m:exit() end)

-- Set up our grid
hs.window.animationDuration = 0
hs.grid.setMargins({25,25})
hs.grid.setGrid('10x10')

-- Common window positions
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

-- List of hotkeys assigned to common apps
local appKeys = {
  -- osascript -e 'id of app "Foo"'
  [","] = "com.apple.systempreferences",
  ["c"] = "com.google.Chrome",
  ["d"] = "com.apple.iCal",
  ["e"] = "com.apple.mail",
  ["f"] = "com.apple.finder",
  ["g"] = "org.whispersystems.signal-desktop",
  ["i"] = "pro.writer.mac",
  ["k"] = "net.kovidgoyal.kitty",
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

-- List of hotkeys assigned to common webapps
local webAppKeys = {
  ["l"] = "app.slack.com",
  ["o"] = "outlook.office.com",
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
    if not hs.fnutils.contains(myApps, thisApp) then
      window:application():hide()
    end
  end
end

local function openChromeTab(searchTerm)
  hs.task.new(
    "/etc/profiles/per-user/"..os.getenv("USER").."/bin/chrome-tab",
    nil,
    function(exitCode, stdOut, stdErr) print(stdErr) return true end,
    { searchTerm }
  ):start()
  hs.application.open("com.google.Chrome")
end

-- Show apps with their hotkey
for k, v in pairs(appKeys) do
  m:bind("", k, function()
    hideAppsExcept({v})
    hs.grid.set(hs.application.get(v):mainWindow(), screenPositions.big)
    m:exit()
  end)
end

-- Show web apps (via tabs in Google Chrome) with their hotkey
for k, v in pairs(webAppKeys) do
  m:bind("", k, function()
    openChromeTab(v)
    hideAppsExcept({"com.google.Chrome"})
    hs.grid.set(hs.window.focusedWindow(), screenPositions.big)
    m:exit()
  end)
end

-- Split screen with another app
for k, v in pairs(appKeys) do
  m:bind("shift", k, function()
    hs.grid.set(hs.window.focusedWindow(), screenPositions.left)
    hs.grid.set(hs.application.open(v):mainWindow(), screenPositions.right)
    m:exit()
  end)
end

-- Navigate windows
m:bind("", "up", function() hs.window.filter.focusNorth() m:exit() end)
m:bind("", "right", function() hs.window.filter.focusEast() m:exit() end)
m:bind("", "down", function() hs.window.filter.focusSouth() m:exit() end)
m:bind("", "left", function() hs.window.filter.focusWest() m:exit() end)

-- Resize windows
m:bind("shift", "up", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.big) m:exit() end)
m:bind("shift", "right", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.right) m:exit() end)
m:bind("shift", "down", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.middle) m:exit() end)
m:bind("shift", "left", function() hs.grid.set(hs.window.focusedWindow(), screenPositions.left) m:exit() end)

-- Window layout for common terminal/browser work
m:bind("", "1", function()
  hideAppsExcept({"com.google.Chrome", "net.kovidgoyal.kitty"})
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.right)
  m:exit()
end)

-- Window layout for virtual meetings
m:bind("", "2", function()
  hideAppsExcept({"us.zoom.xos", "pro.writer.mac", "com.google.Chrome"})
  hs.grid.set(hs.application.open("us.zoom.xos"):getWindow('Zoom Meeting'), screenPositions.left_top)
  hs.grid.set(hs.application.open("pro.writer.mac"):mainWindow(), screenPositions.left_bottom)
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.right)
  hs.application.get("us.zoom.xos"):getWindow('Zoom Meeting'):close()
  openChromeTab("app.slack.com")
  m:exit()
end)

-- Window layout for planning
m:bind("", "3", function()
  hideAppsExcept({"com.apple.iCal", "com.apple.reminders"})
  hs.grid.set(hs.application.open("com.apple.iCal"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("com.apple.reminders"):mainWindow(), screenPositions.right)
  m:exit()
end)

-- Window layout for completing timesheets
m:bind("", "4", function()
  hideAppsExcept({"pro.writer.mac", "com.google.Chrome"})
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("pro.writer.mac"):mainWindow(), screenPositions.right)
  openChromeTab("harvestapp.com")
  m:exit()
end)

-- Window layout for working on Hammerspoon
m:bind("", "h", function()
  hideAppsExcept({"net.kovidgoyal.kitty", "org.hammerspoon.Hammerspoon"})
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("org.hammerspoon.Hammerspoon"):mainWindow(), screenPositions.right)
  hs.console.clearConsole()
  hs.reload()
  m:exit()
end)
