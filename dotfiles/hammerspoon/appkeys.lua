-- Set up our grid
hs.window.animationDuration = 0
hs.grid.setMargins({0,0})
hs.grid.setGrid('10x10')

-- Common window positions
screenPositions = {
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
-- Bundle IDs can be found with `osascript -e 'id of app "Foo"'`
local appKeys = {
  [","] = "com.apple.systempreferences",
  ["c"] = "com.google.Chrome",
  ["d"] = "com.apple.iCal",
  ["e"] = "com.apple.mail",
  ["f"] = "com.apple.finder",
  ["g"] = "org.whispersystems.signal-desktop",
  ["h"] = "com.apple.Home",
  ["i"] = "pro.writer.mac",
  ["k"] = "net.kovidgoyal.kitty",
  ["m"] = "com.apple.MobileSMS",
  ["n"] = "com.apple.Notes",
  ["r"] = "com.apple.reminders",
  ["s"] = "com.apple.Safari",
  ["t"] = "net.kovidgoyal.kitty", -- t for terminal, for muscle memory
  ["u"] = "com.apple.Music",
  ["z"] = "us.zoom.xos",
}

-- List of hotkeys assigned to common webapps
local webAppKeys = {
  ["l"] = "app.slack.com/client",
  ["o"] = "outlook.office.com",
}

-- Hide or open an app with it's hotkey
function toggleApp(myApp)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.application.find(myApp)
  if app ~= nil and app:isFrontmost() then
    app:hide()
  else
    hs.application.open(myApp)
  end
end

-- Hide all apps except for the ones we want
function hideAppsExcept(myApps)
  for _, app in ipairs(myApps) do
    hs.application.open(app, 5, true)
  end
  for _, window in pairs(hs.window.visibleWindows()) do
    thisApp = window:application():bundleID()
    if not hs.fnutils.contains(myApps, thisApp) then
      window:application():hide()
    end
  end
end

-- Use `chrome-cli` to show or create the tab we want
function openChromeTab(searchTerm)
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
    m:exit()
    hideAppsExcept({v})
    hs.grid.set(hs.application.open(v, 5, true):mainWindow(), screenPositions.big)
  end)
end

-- Show web apps (via tabs in Google Chrome) with their hotkey
for k, v in pairs(webAppKeys) do
  m:bind("", k, function()
    m:exit()
    openChromeTab(v)
    hideAppsExcept({"com.google.Chrome"})
    hs.grid.set(hs.window.focusedWindow(), screenPositions.big)
  end)
end

-- Split screen with another app
for k, v in pairs(appKeys) do
  m:bind("shift", k, function()
    m:exit()
    hs.grid.set(hs.window.focusedWindow(), screenPositions.left)
    hs.grid.set(hs.application.open(v, 5, true):mainWindow(), screenPositions.right)
  end)
end

-- Navigate windows
m:bind("", "up", function() m:exit() hs.window.filter.focusNorth() end)
m:bind("", "right", function() m:exit() hs.window.filter.focusEast() end)
m:bind("", "down", function() m:exit() hs.window.filter.focusSouth() end)
m:bind("", "left", function() m:exit() hs.window.filter.focusWest() end)

-- Resize windows
m:bind("shift", "up", function() m:exit() hs.grid.set(hs.window.focusedWindow(), screenPositions.big) end)
m:bind("shift", "right", function() m:exit() hs.grid.set(hs.window.focusedWindow(), screenPositions.right) end)
m:bind("shift", "down", function() m:exit() hs.grid.set(hs.window.focusedWindow(), screenPositions.middle) end)
m:bind("shift", "left", function() m:exit() hs.grid.set(hs.window.focusedWindow(), screenPositions.left) end)

-- Quit all open apps and windows
m:bind("", "q", function()
  m:exit()
  hs.osascript.applescript([[
    -- get list of open apps
    tell application "System Events"
      set allApps to displayed name of (every process whose background only is false) as list
    end tell

    -- leave some apps open
    set exclusions to {"Hammerspoon"}

    -- quit each app
    repeat with thisApp in allApps
      set thisApp to thisApp as text
      if thisApp is not in exclusions then
        tell application thisApp to quit
      end if
    end repeat
  ]])
end)

-- Open "Password manager"
m:bind("", "x", function()
  m:exit()
  local prefPane = "/System/Library/PreferencePanes/Passwords.prefPane"
  hs.task.new("/usr/bin/open", nil, function() return true end, { prefPane }):start()
  hs.application.open("com.apple.systempreferences", 5, true):mainWindow():centerOnScreen()
end)

-- Window layout for common terminal/browser work
m:bind("", "1", function()
  m:exit()
  hideAppsExcept({"com.google.Chrome", "net.kovidgoyal.kitty"})
  hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.right)
end)

-- Window layout for task management
m:bind("", "2", function()
  m:exit()
  hideAppsExcept({"com.apple.iCal", "com.apple.reminders"})
  hs.grid.set(hs.application.open("com.apple.iCal"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("com.apple.reminders"):mainWindow(), screenPositions.right)
end)

-- Window layout for working on Hammerspoon
m:bind("", "p", function()
  m:exit()
  hideAppsExcept({"net.kovidgoyal.kitty", "org.hammerspoon.Hammerspoon"})
  hs.grid.set(hs.application.open("net.kovidgoyal.kitty"):mainWindow(), screenPositions.left)
  hs.grid.set(hs.application.open("org.hammerspoon.Hammerspoon"):mainWindow(), screenPositions.right)
  hs.console.clearConsole()
end)
