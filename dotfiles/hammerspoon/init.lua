-- Reload hammerspoon configuration whenever it changes
hs.alert("Hammerspoon config loaded")
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(paths, flagTables)
  for _, file in pairs(paths) do
    if file:sub(-4) == ".lua" then
      hs.reload()
    end
  end
end):start()

-- Set up our leader key
leaderKey = "f14"

-- Set up our modal
m = hs.hotkey.modal.new("", leaderKey)

function m:entered()
  mIndicator = hs.alert"⌘"
  hs.timer.doAfter(2, function() m:exit() end)
end

function m:exited()
  hs.alert.closeSpecific(mIndicator)
end

m:bind("", "escape", function() m:exit() end)
m:bind("", leaderKey, function() m:exit() end)

-- Load additional Hammerspoon config
require "appkeys"
require "chooser"
require "local"
